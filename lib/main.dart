import 'package:descolar_front/features/profil/presentation/providers/edit_profil_provider.dart';
import 'package:flutter/material.dart';

import 'package:descolar_front/features/messages/presentation/provider/message_provider.dart';
import 'package:descolar_front/features/profil/presentation/providers/profil_provider.dart';
import 'package:descolar_front/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:descolar_front/features/search/presentation/providers/search_provider.dart';
import 'package:descolar_front/config/routes/app_routes.dart';
import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:descolar_front/features/post/presentation/providers/action_post_provider.dart';
import 'package:descolar_front/features/post/presentation/providers/get_post_provider.dart';
import 'package:descolar_front/features/post/presentation/providers/new_post_provider.dart';
import 'package:descolar_front/screens/splash_screen.dart';
import 'package:descolar_front/core/constants/websocket.dart';


void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check si la déconnexion du websocket marche
    debugPrint('LIFE CYCLE NEW STATE : $state');
    if (state == AppLifecycleState.detached) {
      WebSocket.disconnect();
    }
  }

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
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => MessageProvider()),
        ChangeNotifierProvider(create: (context) => EditProfilProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoutes,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: const [Locale('fr', 'FR')],
            title: 'Descolar',
            theme: AppTheme.theme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
