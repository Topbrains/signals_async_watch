import 'package:flutter/material.dart';

class FullName extends StatelessWidget {
  const FullName({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter full name';
        }
        return null;
      },
    );
  }
}
