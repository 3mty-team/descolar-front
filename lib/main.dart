import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:descolar_front/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignupProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        // change to false for release
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        // /!\ MAYBE USELESS WITH PROVIDERS /!\
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr'),
        ],
        title: 'Descolar',
        theme: AppTheme.theme(),
        home: const SplashScreen(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.homeAppBar(context),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
    );
  }
}
