import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/auth/business/usecases/get_user.dart';
import 'package:descolar_front/features/auth/data/datasources/user_local_data_source.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:descolar_front/features/auth/data/repositories/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void connect(BuildContext context) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrUser = await GetUser(userRepository: repository).call(
      params: UserLoginParams(
        username: controllers[LoginInputName.login]!.text,
        password: controllers[LoginInputName.password]!.text,
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        if (failure is NotExistsFailure) {
          changeError(
            LoginInputName.login,
            'Le pseudonyme ou le mot de passe est incorrect',
          );
          changeError(
            LoginInputName.password,
            'Le pseudonyme ou le mot de passe est incorrect',
          );
        }
        notifyListeners();
      },
      (UserEntity user) {
        Navigator.pushReplacementNamed(context, '/home');
        notifyListeners();
      },
    );
  }
}
