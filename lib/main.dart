import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/config/routes/app_routes.dart';
import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/providers/new_post_provider.dart';
import 'package:descolar_front/screens/splash_screen.dart';

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
        ChangeNotifierProvider(create: (context) => NewPostProvider()),
        ChangeNotifierProvider(create: (context) => GetPostProvider()),
        ChangeNotifierProvider(create: (context) => ActionPostProvider()),
        ChangeNotifierProvider(create: (context) => ProfilProvider()),
      ],
      child: MaterialApp(
        // change to false for release
        debugShowCheckedModeBanner: true,
        // /!\ MAYBE USELESS WITH PROVIDERS /!\
        onGenerateRoute: AppRoutes.onGenerateRoutes,
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
