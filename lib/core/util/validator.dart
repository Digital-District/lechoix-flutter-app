import 'package:easy_localization/easy_localization.dart';

class Validator {
  static String? defaultValidator(String? value) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (value != null && value.trim().isEmpty) {
      return tr("error_field_required");
    }
    // else if (value!.replaceAll(r' ', '').contains(arabicRegex, 0)) {
    //   return tr("write_in_english");
    // }
    return null;
  }

  static String? name(String? value) {
    // final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (value != null) {
      // final noSpaces = value.replaceAll(r' ', '');
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_filed_required");
      }
      // else if (noSpaces.contains(arabicRegex, 0)) {
      //   return tr("write_in_english");
      // }
      //  else if (value.split(" ").length <= 2) {
      //   return tr("enter_complete_name");
      // }
    }
    return null;
  }
  // static String? name(String? value) {
  //   final arabicRegex = RegExp(r'[ء-ي-_ \.]*$');
  //   if (value != null) {
  //     value = value.trim();
  //     if (value.isEmpty) {
  //       return tr("error_filed_required");
  //     } else if (value.contains(arabicRegex)) {
  //       return tr("write_in_english");
  //     } else if (value.split(" ").length <= 2) {
  //       return tr("enter_full_name");
  //     }
  //   }
  //   return null;
  // }

  // static String? name(String? value) {
  //   final arabicRegex = RegExp(r'[ء-ي-_ \.]*$');
  //   if (value != null) {
  //     value = value.trim();
  //     if (value.isEmpty) {
  //       return tr("error_filed_required");
  //     } else if (value.contains(arabicRegex)) {
  //       return tr("مسااائةةة");
  //     } else if (value.split(" ").length <= 2) {
  //       return tr("error_filed_required");
  //     }
  //   }
  //   return null;
  // }

  // static String? phone(String? value) {
  //   if (value != null) {
  //     value = value.trim();
  //     if (value.isEmpty) {
  //       return tr("error_filed_required");
  //     } else if (!value.startsWith('5') && value.length != 9) {
  //       return tr("phone_length_must_be_9_numbers");
  //     }
  //   }
  //   return null;
  // }
  static String? phone(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_field_required");
      }
      // else if (!value.startsWith('+')) {
      //   return tr("enter_phone_code");
      // }
      // else if (!value.startsWith('5') || value.length != 9) {
      //   return tr("error_phone_length");
      // }
    }
    return null;
  }

  static String? text(String? value) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_field_required");
      } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
        return tr("enter_correct_name");
      }
    } else if (value!.replaceAll(r' ', '').contains(arabicRegex, 0)) {
      return tr("write_in_english");
    }
    return null;
  }

  static String? defaultEmptyValidator(String? value) {
    return null;
  }

  static String? email(String? value) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (value != null) {
      value = value.trim();
      value = value.toLowerCase();
      if (value.isEmpty) {
        return tr("error_field_required");
      } else if (!RegExp(

              // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
              // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
              r"^[[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
        return tr("error_email_regex");
      }
    } else if (value!.replaceAll(r' ', '').contains(arabicRegex, 0)) {
      return tr("write_in_english");
    } else {
      return tr("error_field_required");
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_field_required");
        // } else if (!RegExp(
        //         r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
        //     .hasMatch(value)) {
        //   return tr("error_password_validation");
      } else if (value.length < 8) {
        return tr("error_password_length");
      }
    } else {
      return tr("error_field_required");
    }
    return null;
  }

  static String? idValidation(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_field_required");
      } else if (!RegExp(r"^[A-Z a-z 0-9]{8,25}$").hasMatch(value)) {
        return tr("id_validation");
      }
    } else {
      return tr("error_field_required");
    }
    return null;
  }

  static String? confirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword != null) {
      confirmPassword = confirmPassword.trim();
      if (confirmPassword.isEmpty) {
        return tr("error_field_required");
      } else if (confirmPassword != password) {
        return tr("error_wrong_password_confirm");
      }
    } else {
      return tr("error_field_required");
    }
    return null;
  }

  static String? numbers(String? value) {
    if (value != null) {
      value = value.trim();
      if (value.isEmpty) {
        return tr("error_field_required");
      }
      final number = int.tryParse(value);
      if (number == null) {
        return tr("error_wrong_input");
      }
    } else {
      return tr("error_field_required");
    }
    return null;
  }
}
