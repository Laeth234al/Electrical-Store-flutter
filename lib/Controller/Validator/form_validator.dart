class FormValidator {
  // Email validation
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9.!#$%&' '*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*\$');
    return regex.hasMatch(email);
  }

  // Password validation
  bool isValidPassword(String password) {
    return password.length > 7;
  }

  // Name validation
  bool isValidUserName(String user) {
    return user.isNotEmpty;
  }
}
