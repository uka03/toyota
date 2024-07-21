extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  }

  bool isValidPassword() {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(this);
  }

  bool isValidUsername() {
    return RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(this);
  }

  bool isValidName() {
    return RegExp(r'^[a-zA-Z-]+$').hasMatch(this);
  }

  String? isGoodPassword() {
    RegExp numbersRegex = RegExp(r"\d");

    if (length < 8) {
      return 'Хэт богино байна.';
    }
    if (!numbersRegex.hasMatch(this)) {
      return 'Нууц үгэнд тоо ороогүй байна.';
    }

    if (this == toUpperCase()) {
      return 'Жижиг үсэг ороогүй байна.';
    }

    if (this == toLowerCase()) {
      return 'Том үсэг ороогүй байна.';
    }

    return null;
  }
}

extension NullableStringExtensions on String? {
  String orEmpty() {
    switch (this == null) {
      case false:
        return this!;
      default:
        return "";
    }
  }
}
