import 'package:descolar_front/core/constants/user_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/auth/business/repositories/user_repository.dart';
import 'package:descolar_front/features/auth/business/usecases/get_user.dart';
import 'package:flutter/material.dart';

enum LoginInputName { login, password }

class LoginProvider extends ChangeNotifier {
  bool isLoging = false;
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

  void connect(BuildContext context) async {
    isLoging = true;
    notifyListeners();
    UserRepository repository = await UserRepository.getUserRepository();

    final failureOrUser = await GetUser(userRepository: repository).call(
      params: UserLoginParams(
        username: controllers[LoginInputName.login]!.text,
        password: controllers[LoginInputName.password]!.text,
        remember: checkboxRememberMe,
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        isLoging = false;
        changeError(
          LoginInputName.login,
          failure.errorMessage,
        );
        changeError(
          LoginInputName.password,
          failure.errorMessage,
        );
        notifyListeners();
      },
      (UserEntity user) {
        isLoging = false;
        UserInfo.setUserInfo();
        Navigator.pushReplacementNamed(context, '/home');
        notifyListeners();
      },
    );
  }
}
