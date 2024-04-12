import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactId extends StatelessWidget {
  const ContactId({
    super.key,
    required this.idController,
  });

  final TextEditingController idController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: idController,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: const InputDecoration(labelText: 'ID'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid ID';
        }
        return null;
      },
    );
  }
}
