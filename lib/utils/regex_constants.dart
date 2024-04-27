class ProjectRegex {
  ProjectRegex._();

  static const String _emailRegex =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String? firstNameValidator(String? text) {
    if (text!.trim().isEmpty) {
      return 'Please enter first name';
    }
    final regex = RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]');

    if (regex.hasMatch(text)) {
      return 'Numbers and Symbols not allowed';
    }
    return null;
  }

  static String? lastNameValidator(String? text) {
    if (text!.trim().isEmpty) {
      return 'Please enter last name';
    }
    final regex = RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]');

    if (regex.hasMatch(text)) {
      return 'Numbers and Symbols not allowed';
    }
    return null;
  }

  static String? otpInputValidator(String? text) {
    if (text!.trim().isEmpty) {
      return 'Otp cannot be empty';
    } else if (text.length != 6) {
      return 'Otp character length should be 6';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
      return 'Otp can only contain numbers';
    }
    return null;
  }

  static String? emailValidator(String? email) {
    if (email!.trim().isEmpty) {
      return 'Please enter your email address';
    }

    if (email.isNotEmpty) {
      final regex = RegExp(_emailRegex);
      final emailValidate = regex.hasMatch(email);

      if (emailValidate) {
        return null;
      }

      return 'Please enter valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? text) {
    if (text!.trim().isEmpty) {
      return 'Please enter a password.';
    }

    if (text.length < 8) {
      return 'Password should be greater than 8 characters.';
    }

    if (!text.contains(RegExp('[A-Z]'))) {
      return 'Password must contain one uppercase letter.';
    }

    if (!text.contains(RegExp('[a-z]'))) {
      return 'Password must contain one lowercase letter.';
    }

    if (!text.contains(RegExp('[0-9]'))) {
      return 'Password must contain one number.';
    }

    if (!text.contains(RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]'))) {
      return 'Password must contain one special character.';
    }

    return null;
  }

  static String otpValidator(String otp) {
    if (otp.isEmpty) {
      return 'Please enter code';
    }
    if (otp.length != 4 || !RegExp(r'^[0-9]+$').hasMatch(otp)) {
      return 'Please enter correct code';
    }
    return '';
  }

  static String bioValidator(String bio) {
    if (bio.trim().isEmpty) {
      return 'Please enter your bio';
    }
    return '';
  }

  static String? descriptionValidator(String? des) {
    if (des!.trim().isEmpty) {
      return 'Please enter your description';
    }
    return null;
  }

  static String? reasonValidator(String? des) {
    if (des!.trim().isEmpty) {
      return 'Please enter your reason';
    }
    return null;
  }

  static String? streetValidator(String? street) {
    if (street!.trim().isEmpty) {
      return 'Please enter your street';
    }
    return null;
  }

  static String? houseValidator(String? house) {
    if (house!.trim().isEmpty) {
      return 'Please enter your house no';
    }
    return null;
  }

  static String? floorValidator(String? floor) {
    if (floor!.trim().isEmpty) {
      return 'Please enter your floor';
    }
    return null;
  }

  static String? cityValidator(String? city) {
    if (city!.trim().isEmpty) {
      return 'Please enter your city';
    }
    return null;
  }

  static String? stateValidator(String? state) {
    if (state!.trim().isEmpty) {
      return 'Please enter your state';
    }
    return null;
  }

  static String? zipValidator(String? zip) {
    if (zip!.trim().isEmpty) {
      return 'Please enter your zip code';
    }
    if (zip.length > 5) {
      return 'Please enter correct code';
    }
    return null;
  }

  static String? jobTitleValidator(String? title) {
    if (title!.trim().isEmpty) {
      return 'Please enter your job title';
    }
    return null;
  }

  static String? numberOfPackageValidator(String? numberOfPackage) {
    if (numberOfPackage!.trim().isEmpty) {
      return 'Please enter your package count';
    }
    return null;
  }

  static String? jobAmountValidator(String? amount) {
    if (amount!.trim().isEmpty) {
      return 'Please enter your amount';
    }
    return null;
  }

  static String? tipValidator(String? tip) {
    if (tip!.trim().isEmpty) {
      return 'Please enter your amount';
    }
    return null;
  }

  static String? reviewValidator(String? review) {
    if (review!.trim().isEmpty) {
      return 'Please enter your review';
    }
    return null;
  }
}
