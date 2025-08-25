class Validators {
  /// Checks if the value is not null and not empty.
  static String? required(String? value, {String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Checks if the value has at least [minLength] characters.
  static String? minLength(String? value, int minLength, {String? message}) {
    if (value == null || value.length < minLength) {
      return message ?? 'Must be at least $minLength characters';
    }
    return null;
  }

  /// Checks if the value has at most [maxLength] characters.
  static String? maxLength(String? value, int maxLength, {String? message}) {
    if (value == null || value.length > maxLength) {
      return message ?? 'Must be at most $maxLength characters';
    }
    return null;
  }

  /// Checks if the value is a valid email address.
  static String? email(String? value, {String? message}) {
    if (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return message ?? 'Enter a valid email';
    }
    return null;
  }

  /// Checks if the value is a valid password (at least 6 characters).
  static String? password(String? value, {String? message}) {
    if (value == null || value.length < 6) {
      return message ?? 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Checks if the value is a valid number.
  static String? number(String? value, {String? message}) {
    if (value == null || int.tryParse(value) == null) {
      return message ?? 'Enter a valid number';
    }
    return null;
  }

  /// Checks if the value is a valid URL.
  static String? url(String? value, {String? message}) {
    if (value == null || !RegExp(r'^https?:\/\/.*').hasMatch(value)) {
      return message ?? 'Enter a valid URL';
    }
    return null;
  }

  /// Checks if the value is a valid phone number (10 digits).
  static String? phone(String? value, {String? message}) {
    if (value == null || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return message ?? 'Enter a valid phone number';
    }
    return null;
  }

  /// Checks if the value is a valid date.
  static String? date(String? value, {String? message}) {
    if (value == null || DateTime.tryParse(value) == null) {
      return message ?? 'Enter a valid date';
    }
    return null;
  }

  /// Checks if the value is the same as [otherValue].
  static String? compare(
    String? value,
    String? otherValue, {
    required String message,
  }) {
    if (value != otherValue) {
      return message;
    }
    return null;
  }

  /// Checks if the value is not empty (trims whitespace).
  static String? notEmpty(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field cannot be empty';
    }
    return null;
  }

  /// Checks if the value is a number greater than or equal to [minValue].
  static String? minValue(String? value, int minValue, {String? message}) {
    if (value == null ||
        int.tryParse(value) == null ||
        int.parse(value) < minValue) {
      return message ?? 'Value must be at least $minValue';
    }
    return null;
  }

  /// Checks if the value is a number less than or equal to [maxValue].
  static String? maxValue(String? value, int maxValue, {String? message}) {
    if (value == null ||
        int.tryParse(value) == null ||
        int.parse(value) > maxValue) {
      return message ?? 'Value must be at most $maxValue';
    }
    return null;
  }

  /// Checks if the value is a valid credit card number.
  static String? creditCard(String? value, {String? message}) {
    if (value == null ||
        !RegExp(
          r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$',
        ).hasMatch(value)) {
      return message ?? 'Enter a valid credit card number';
    }
    return null;
  }

  /// Checks if the value is a valid IP address.
  static String? ipAddress(String? value, {String? message}) {
    if (value == null ||
        !RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$').hasMatch(value)) {
      return message ?? 'Enter a valid IP address';
    }
    return null;
  }

  /// Checks if the value is a valid slug.
  static String? slug(String? value, {String? message}) {
    if (value == null ||
        !RegExp(r'^[a-z0-9]+(?:-[a-z0-9]+)*$').hasMatch(value)) {
      return message ?? 'Enter a valid slug';
    }
    return null;
  }

  /// Checks if the value contains only alphabetic characters.
  static String? alpha(String? value, {String? message}) {
    if (value == null || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return message ?? 'Enter only alphabetic characters';
    }
    return null;
  }

  /// Checks if the value contains only alphanumeric characters.
  static String? alphanumeric(String? value, {String? message}) {
    if (value == null || !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return message ?? 'Enter only alphanumeric characters';
    }
    return null;
  }

  /// Checks if the value is a valid JSON string.
  static String? isJson(String? value, {String? message}) {
    if (value == null || !RegExp(r'^{[^{}]*}$').hasMatch(value)) {
      return message ?? 'Enter a valid JSON string';
    }
    return null;
  }

  /// Checks if the value is a valid JWT.
  static String? isJwt(String? value, {String? message}) {
    if (value == null ||
        !RegExp(
          r'^[A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$',
        ).hasMatch(value)) {
      return message ?? 'Enter a valid JWT';
    }
    return null;
  }

  /// Checks if the value is in the given list.
  static String? inList(String? value, List<String> list, {String? message}) {
    if (value == null || !list.contains(value)) {
      return message ?? 'Value is not in the list';
    }
    return null;
  }

  /// Checks if the value is not in the given list.
  static String? notInList(String? value, List<String> list, {String? message}) {
    if (value == null || list.contains(value)) {
      return message ?? 'Value is in the list';
    }
    return null;
  }

  /// Checks if the value is a valid file extension.
  static String? fileExtension(String? value, List<String> extensions, {String? message}) {
    if (value == null || !extensions.any((ext) => value.endsWith(ext))) {
      return message ?? 'Invalid file extension';
    }
    return null;
  }

  /// Checks if the value is a valid credit card expiration date.
  static String? creditCardExpirationDate(String? value, {String? message}) {
    if (value == null || !RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{4}|[0-9]{2})$').hasMatch(value)) {
      return message ?? 'Invalid expiration date';
    }
    return null;
  }

  /// Checks if the value is a valid CVV.
  static String? cvv(String? value, {String? message}) {
    if (value == null || !RegExp(r'^[0-9]{3,4}$').hasMatch(value)) {
      return message ?? 'Invalid CVV';
    }
    return null;
  }

  /// Checks if the value is a valid ISBN.
  static String? isbn(String? value, {String? message}) {
    if (value == null || !RegExp(r'^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$').hasMatch(value)) {
      return message ?? 'Invalid ISBN';
    }
    return null;
  }
}