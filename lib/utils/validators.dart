
class Validators {
  /// Validate if the provided email is valid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Regular expression for email validation
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validate if the provided password meets certain strength requirements
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    // Password strength: at least 6 characters
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  /// Validate if a field is not empty
  static String? validateNonEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  /// Validate phone number (basic validation)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  /// Confirm that two password fields match
  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (password == null || confirmPassword == null) {
      return 'Password fields cannot be empty';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validate the name fields
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return 'Name must contain only alphabets';
    }
    return null;
  }

}
