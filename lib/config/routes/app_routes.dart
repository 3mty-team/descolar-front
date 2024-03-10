/* 
  /!\ MAYBE USELESS WITH PROVIDERS /!\ 
*/

import 'package:descolar_front/main.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const Home());
      case 'settings':
        return null; //Must be modified when the configuration page is created

      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
