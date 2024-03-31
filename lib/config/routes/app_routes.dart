/*
  /!\ MAYBE USELESS WITH PROVIDERS /!\ 
*/

import 'package:descolar_front/features/auth/presentation/pages/login_page.dart';
import 'package:descolar_front/features/auth/presentation/pages/signup_page.dart';
import 'package:descolar_front/features/auth/presentation/pages/user_created_success.dart';

import 'package:descolar_front/main.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _materialRoute(const Home());

      case '/search':
        return _materialRoute(const Home());
      case '/newPost':
        return _materialRoute(const Home());
      case '/myProfil':
        return _materialRoute(const Home());
      case '/messages':
        return _materialRoute(const Home());
      case '/settings':
        return _materialRoute(const Home());

      case '/signup':
        return _materialRoute(const SignupPage());
      case '/login':
        return _materialRoute(const LoginPage());
      case '/user-created-success':
        return _materialRoute(const UserCreatedSuccessPage());

      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
