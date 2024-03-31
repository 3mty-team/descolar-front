import 'package:flutter/material.dart';

enum LoginInputName { login, password }

class LoginProvider extends ChangeNotifier {
  bool? checkboxRememberMe = false;
  Map<LoginInputName, TextEditingController> controllers = {
    LoginInputName.login: TextEditingController(),
    LoginInputName.password: TextEditingController(),
  };
  Map<LoginInputName, String?> errors = {
    LoginInputName.login: null,
    LoginInputName.password: null,
  };

  void reset() {
    checkboxRememberMe = false;
    controllers = {
      LoginInputName.login: TextEditingController(),
      LoginInputName.password: TextEditingController(),
    };
    errors = {
      LoginInputName.login: null,
      LoginInputName.password: null,
    };
    notifyListeners();
  }

  void changeError(LoginInputName name, String? message) {
    this.errors[name] = message;
    notifyListeners();
  }

  void removeError(LoginInputName name) {
    changeError(name, null);
  }

  bool validateForm() {
    bool isValid = true;
    isValid = _validateLogin() && isValid;
    isValid = _validatePassword() && isValid;
    return isValid;
  }

  bool _validateLogin() {
    String value = controllers[LoginInputName.login]!.text.trim();
    if (value.isEmpty) {
      changeError(
        LoginInputName.login,
        'Veuillez renseigner votre email ou votre pseudonyme',
      );
      return false;
    }
    removeError(
      LoginInputName.login,
    );
    return true;
  }

  bool _validatePassword() {
    String value = controllers[LoginInputName.password]!.text.trim();
    if (value.isEmpty) {
      changeError(
        LoginInputName.password,
        'Veuillez renseigner votre mot de passe',
      );
      return false;
    }
    removeError(LoginInputName.password);
    return true;
  }
}
