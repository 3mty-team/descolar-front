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
      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
