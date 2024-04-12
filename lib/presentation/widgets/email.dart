import 'package:flutter/material.dart';

import '../../logic/validate_email.dart';

class Email extends StatelessWidget {
  const Email({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (value) => validateEmail(value!.trim()),
    );
  }
}
