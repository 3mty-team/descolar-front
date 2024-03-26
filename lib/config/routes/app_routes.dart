/* 
  /!\ MAYBE USELESS WITH PROVIDERS /!\ 
*/

import 'package:descolar_front/features/auth/presentation/pages/login_page.dart';
import 'package:descolar_front/features/auth/presentation/pages/signup_page.dart';
import 'package:descolar_front/main.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _materialRoute(const Home());

      case '/signup':
        return _materialRoute(const SignupPage());
      case '/login':
        return _materialRoute(const LoginPage());


      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
