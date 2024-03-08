/* 
  /!\ MAYBE USELESS WITH PROVIDERS /!\ 
*/

import 'package:descolar_front/main.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return materialRoute(const Home());

      default:
        return materialRoute(const Home());
    }
  }

  static Route<dynamic> materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
