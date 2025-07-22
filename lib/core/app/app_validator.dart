import 'package:flutter/material.dart';
import 'package:shartflix/support/app_lang.dart';
import 'package:validators/validators.dart';

class AppValidator {
  static AppValidator? _instance;
  static AppValidator get instance => _instance ??= AppValidator._init();

  AppValidator._init();

  FormFieldValidator<String>? get emailValidator => (value) {
    if (value == null || value.trim().isEmpty) {
      return lang(LocaleKeys.emailRequired);
    }

    if (!isEmail(value.trim())) {
      return lang(LocaleKeys.emailInvalid);
    }

    return null;
  };

  FormFieldValidator<String> get passwordValidator => (value) {
    if (value == null || value.trim().isEmpty) {
      return lang(LocaleKeys.passwordRequired);
    }

    if (value.trim().length < 3 || value.trim().length > 12) {
      return lang(LocaleKeys.passwordMinLength);
    }

    return null;
  };

  FormFieldValidator<String>? confirmValidator(TextEditingController? controller) =>
      (value) {
        var v = passwordValidator(value?.trim());
        if (v != null) return v;
        if (controller?.text.trim() != value) {
          return lang(LocaleKeys.passwordsMismatch);
        }
        return null;
      };

  FormFieldValidator<String> get nameValidator => (value) {
    if (value == null || value.trim().isEmpty) return lang(LocaleKeys.fullNameRequired);

    return null;
  };
}
