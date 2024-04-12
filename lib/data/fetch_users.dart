import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:signals/signals_flutter.dart';

import 'contact_model.dart';

// Create a signal to store the contacts list. This is a future signal.
// The signal will be updated with the data fetched from the API.
final fetchContacts$ = futureSignal(() => _fetchContacts());


// Here we are fetching the data from the API. If the response is
// successful, we decode the data and return a list of contacts.
// If the response is not successful, we throw an exception.
Future<List<Contact>> _fetchContacts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    final decodedData = jsonDecode(response.body) as List;

    /// Update the signal value with the new data.
    return decodedData.map((user) => Contact.fromJson(user)).toList();
  } else {
    // handle error
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
