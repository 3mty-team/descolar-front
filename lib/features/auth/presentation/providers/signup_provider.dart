import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:descolar_front/core/connection/network_info.dart';
import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/params/params.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/auth/business/usecases/create_user.dart';
import 'package:descolar_front/features/auth/data/datasources/user_local_data_source.dart';
import 'package:descolar_front/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:descolar_front/features/auth/data/repositories/user_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SignupInputName {
  email,
  lastname,
  firstname,
  date,
  username,
  diploma,
  formation,
  password,
  confirmpassword,
  cgu,
}

class SignupProvider extends ChangeNotifier {
  int currentStep = 0;
  bool? checkboxCGU = false;
  Map<SignupInputName, TextEditingController> controllers = {
    SignupInputName.email: TextEditingController(),
    SignupInputName.lastname: TextEditingController(),
    SignupInputName.firstname: TextEditingController(),
    SignupInputName.date: TextEditingController(),
    SignupInputName.username: TextEditingController(),
    SignupInputName.diploma: TextEditingController(),
    SignupInputName.formation: TextEditingController(),
    SignupInputName.password: TextEditingController(),
    SignupInputName.confirmpassword: TextEditingController(),
  };
  Map<SignupInputName, String?> errors = {
    SignupInputName.email: null,
    SignupInputName.lastname: null,
    SignupInputName.firstname: null,
    SignupInputName.date: null,
    SignupInputName.username: null,
    SignupInputName.password: null,
    SignupInputName.confirmpassword: null,
    SignupInputName.diploma: null,
    SignupInputName.formation: null,
    SignupInputName.cgu: null,
  };

  void reset() {
    currentStep = 0;
    checkboxCGU = false;
    controllers = {
      SignupInputName.email: TextEditingController(),
      SignupInputName.lastname: TextEditingController(),
      SignupInputName.firstname: TextEditingController(),
      SignupInputName.date: TextEditingController(),
      SignupInputName.username: TextEditingController(),
      SignupInputName.password: TextEditingController(),
      SignupInputName.confirmpassword: TextEditingController(),
      SignupInputName.diploma: TextEditingController(),
      SignupInputName.formation: TextEditingController(),
      SignupInputName.cgu: TextEditingController(),
    };
    errors = {
      SignupInputName.email: null,
      SignupInputName.lastname: null,
      SignupInputName.firstname: null,
      SignupInputName.date: null,
      SignupInputName.username: null,
      SignupInputName.password: null,
      SignupInputName.confirmpassword: null,
      SignupInputName.diploma: null,
      SignupInputName.formation: null,
      SignupInputName.cgu: null,
    };
    notifyListeners();
  }

  void changeError(SignupInputName name, String? message) {
    this.errors[name] = message;
    notifyListeners();
  }

  void removeError(SignupInputName name) {
    changeError(name, null);
  }

  void changeStep(int step) {
    this.currentStep = step;
    notifyListeners();
  }

  void nextStep() {
    changeStep(currentStep + 1);
  }

  void previousStep() {
    changeStep(currentStep - 1);
  }

  bool isLastStep(int lastStep) {
    return currentStep == lastStep;
  }

  bool validateForm() {
    bool isValid = true;
    if (currentStep == 0) {
      isValid = _validateEmail() && isValid;
      isValid = _validateLastname() && isValid;
      isValid = _validateFirstname() && isValid;
      isValid = _validateDate() && isValid;
    } else if (currentStep == 1) {
      isValid = _validateUsername() && isValid;
      isValid = _validatePassword() && isValid;
      isValid = _validateConfirmPassword() && isValid;
      isValid = _validateDiploma() && isValid;
      isValid = _validateFormation() && isValid;
      isValid = _validateCGU() && isValid;
    }
    return isValid;
  }

  bool _validateEmail() {
    String value = controllers[SignupInputName.email]!.text.trim();
    if (value.isEmpty) {
      changeError(
        SignupInputName.email,
        'Veuillez renseigner votre email académique',
      );
      return false;
    }
    final bool isEmailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@etu\.u-paris\.fr",
    ).hasMatch(value);
    if (!isEmailValid) {
      changeError(
        SignupInputName.email,
        'Votre email académique n\'est pas valide',
      );
      return false;
    }
    removeError(SignupInputName.email);
    return true;
  }

  bool _validateLastname() {
    String value = controllers[SignupInputName.lastname]!.text.trim();
    if (value.isEmpty) {
      changeError(
        SignupInputName.lastname,
        'Veuillez renseigner votre nom',
      );
      return false;
    }
    final bool isLastnameValid = RegExp(
      r'^[a-zA-ZÀ-Ÿ- ]*$',
    ).hasMatch(value);
    if (!isLastnameValid) {
      changeError(
        SignupInputName.lastname,
        'Le nom n\'est pas valide',
      );
      return false;
    }
    removeError(SignupInputName.lastname);
    return true;
  }

  bool _validateFirstname() {
    String value = controllers[SignupInputName.firstname]!.text.trim();
    if (value.isEmpty) {
      changeError(
        SignupInputName.firstname,
        'Veuillez renseigner votre prénom',
      );
      return false;
    }
    final bool isFirstnameValid = RegExp(
      r'^[a-zA-ZÀ-Ÿ- ]*$',
    ).hasMatch(value);
    if (!isFirstnameValid) {
      changeError(
        SignupInputName.firstname,
        'Le prénom n\'est pas valide',
      );
      return false;
    }
    removeError(SignupInputName.firstname);
    return true;
  }

  bool _validateDate() {
    String value = controllers[SignupInputName.date]!.text.trim();
    if (value.isEmpty) {
      changeError(
        SignupInputName.date,
        'Veuillez renseigner votre date',
      );
      return false;
    }

    List<String> dateSplitted = value.split('/');
    String formattedDate = '${dateSplitted[2]}-${dateSplitted[1]}-${dateSplitted[0]}';
    final date = DateTime.parse(formattedDate);
    if (AgeCalculator.age(date).years < 18) {
      changeError(
        SignupInputName.date,
        'Vous n\'êtes pas majeur',
      );
      return false;
    }
    removeError(SignupInputName.date);
    return true;
  }

  bool _validateUsername() {
    String value = controllers[SignupInputName.username]!.text.trim();
    if (value.isEmpty) {
      changeError(
        SignupInputName.username,
        'Veuillez renseigner votre pseudonyme',
      );
      return false;
    }
    final bool isUsernameValid = RegExp(
      r'^[a-zA-Z0-9-_]+$',
    ).hasMatch(value);
    if (!isUsernameValid) {
      changeError(
        SignupInputName.username,
        'Le pseudonyme n\'est pas valide',
      );
      return false;
    }
    removeError(SignupInputName.username);
    return true;
  }

  bool _validatePassword() {
    String value = controllers[SignupInputName.password]!.text;
    if (value.isEmpty) {
      changeError(
        SignupInputName.password,
        'Veuillez renseigner votre mot de passe',
      );
      return false;
    }

    final bool isPasswordValid = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{7,255}$',
    ).hasMatch(value);
    if (!isPasswordValid) {
      changeError(
        SignupInputName.password,
        'Votre mot de passe doit faire au minimum 7 caractères avec au moins une majuscule et un chiffre.',
      );
      return false;
    }
    removeError(SignupInputName.password);
    return true;
  }

  bool _validateConfirmPassword() {
    String value = controllers[SignupInputName.confirmpassword]!.text;
    if (value.isEmpty) {
      changeError(
        SignupInputName.confirmpassword,
        'Veuillez confirmer votre mot de passe',
      );
      return false;
    }

    if (value != controllers[SignupInputName.password]!.text) {
      changeError(
        SignupInputName.confirmpassword,
        'Vos mots de passe ne sont pas identiques',
      );
      return false;
    }
    removeError(SignupInputName.confirmpassword);
    return true;
  }

  bool _validateDiploma() {
    String value = controllers[SignupInputName.diploma]!.text;
    if (value.isEmpty) {
      changeError(
        SignupInputName.diploma,
        'Veuillez renseigner le diplôme préparé',
      );
      return false;
    }
    removeError(SignupInputName.diploma);
    return true;
  }

  bool _validateFormation() {
    String value = controllers[SignupInputName.formation]!.text;
    if (value.isEmpty) {
      changeError(
        SignupInputName.formation,
        'Veuillez renseigner la formation préparée',
      );
      return false;
    }
    removeError(SignupInputName.formation);
    return true;
  }

  bool _validateCGU() {
    bool? value = checkboxCGU;
    if (value == false) {
      changeError(
        SignupInputName.cgu,
        'Veuillez accepter les conditions générales d\'utilisation',
      );
      return false;
    }
    removeError(SignupInputName.cgu);
    return true;
  }

  void createUser(BuildContext context) async {
    UserRepositoryImpl repository = UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(dio: Dio()),
      localDataSource: UserLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrUser = await CreateUser(userRepository: repository).call(
      params: UserParams(
        email: controllers[SignupInputName.email]!.text,
        lastname: controllers[SignupInputName.lastname]!.text,
        firstname: controllers[SignupInputName.firstname]!.text,
        dateOfBirth: controllers[SignupInputName.date]!.text,
        username: controllers[SignupInputName.username]!.text,
        password: controllers[SignupInputName.password]!.text,
        diploma: controllers[SignupInputName.diploma]!.text,
        formation: controllers[SignupInputName.formation]!.text,
      ),
    );

    failureOrUser.fold(
      (Failure failure) {
        if (failure is AlreadyExistsFailure) {
          changeError(
            SignupInputName.username,
            'Ce pseudonyme existe déjà',
          );
          changeError(
            SignupInputName.email,
            'Cet email est déjà utilisé',
          );
          changeStep(0);
        }
        notifyListeners();
      },
      (UserEntity user) {
        // Go to success page
        Navigator.pushReplacementNamed(context, '/user-created-success');
        notifyListeners();
      },
    );
  }
}
