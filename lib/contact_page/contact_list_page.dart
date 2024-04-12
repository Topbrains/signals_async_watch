import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../data/contact_model.dart';
import '../data/fetch_users.dart';
import 'widgets/contact_id.dart';
import 'widgets/email.dart';
import 'widgets/full_name.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  ContactListPageState createState() => ContactListPageState();
}

// To make the code easier to read, we will move the logic of some of the widgets for this ContactListPage to a widgets folder.
class ContactListPageState extends State<ContactListPage> {
  Contact? selectedContact;
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  // No need for a controller for the contacts list
  // because we are using a stateful widget
  void addContact() {
    var contact = Contact(
      id: int.parse(idController.text),
      name: nameController.text,
      email: emailController.text,
    );
    contacts$.value = [...contacts$.value, contact];
  }

  void updateContact() {
    selectedContact!.id = int.parse(idController.text);
    selectedContact!.name = nameController.text;
    selectedContact!.email = emailController.text;
    selectedContact = null;
  }

  void editContact(int index) {
    selectedContact = contacts$.value[index];
    idController.text = contacts$.value[index].id.toString();
    nameController.text = contacts$.value[index].name;
    emailController.text = contacts$.value[index].email;
  }

  void clear() {
    idController.clear();
    nameController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  ContactId(idController: idController),
                  FullName(nameController: nameController),
                  Email(emailController: emailController),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: contactButtons,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Watch(
              (context) {
                switch (fetchContacts$.value) {
                  case AsyncData<List<Contact>>():
                    return ListView.builder(
                      itemCount: contacts$.value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(contacts$.value[index].name),
                          subtitle: Text(contacts$.value[index].email),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: contactIcons(index),
                          ),
                          onTap: () {
                            editContact(index);
                            setState(() {});
                          },
                        );
                      },
                    );

                  case AsyncError<List<Contact>>():
                    return Text('Error: ${(fetchContacts$..value.error)}');

                  case AsyncLoading<List<Contact>>():
                    return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> contactIcons(int index) {
    return [
      /// Delete contact on tap
      IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          contacts$.value.removeAt(index);
          clear();
          setState(() {});
        },
      ),

      /// Edit contact on tap
      IconButton(
        icon: const Icon(
          Icons.edit,
          color: Colors.blue,
        ),
        onPressed: () {
          editContact(index);
          setState(() {});
        },
      ),
    ];
  }

  List<Widget> get contactButtons {
    return [
      /// Add contact on tap
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            addContact();
            clear();
            setState(() {});
          }
        },
        child: const Text('Add'),
      ),
      const SizedBox(width: 16),

      /// Update contact on tap
      ElevatedButton(
        onPressed: selectedContact == null
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  updateContact();
                  clear();
                  setState(() {});
                }
              },
        child: const Text('Update'),
      ),
      const SizedBox(width: 16),

      /// Download users on tap
      ElevatedButton(
        /// This is where we call the fetchUsers async function
        onPressed: () async {
          switch (fetchContacts$.value) {
            /// If we have data (AsyncData state), update the contactsSignal value
            case AsyncData data:
              // Add the new data to the existing data
              contacts$.value += data.value!;
            case AsyncError error:
              throw Exception('Error: $error');
            case AsyncLoading():
              break;
          }
        },
        child: const Text('Download'),
      ),
    ];
  }

  //
}
