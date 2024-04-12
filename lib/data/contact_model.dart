import 'package:signals/signals_flutter.dart';

// Normally we would just use a struct (C language) which in Dart is
// implemented as a Typedef, but we need to convert the JSON data to
// a Dart object, so we need a class.
class Contact {
  int id;
  String name;
  String email;

  Contact({required this.id, required this.name, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

// Create a contactList signal.
// Notice that this line replaces the entire ChangeNotifier class.
final contacts$ = <Contact>[].toSignal();
