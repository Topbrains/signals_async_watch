String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }
  // No I don't know what this does. I copied it from the internet. Will never learn RegExp
  if (!RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    caseSensitive: false,
  ).hasMatch(value)) {
    return 'Please enter a valid email';
  }
  // Return null if the email is valid.
  return null;
}
