import 'package:descolar_front/config/routes/app_routes.dart';
import 'package:descolar_front/config/themes/app_themes.dart';
import 'package:descolar_front/core/components/app_bars.dart';
import 'package:descolar_front/core/components/navigation_bar.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/business/repositories/user_repository.dart';
import 'package:descolar_front/features/auth/business/usecases/sign_out.dart';
import 'package:descolar_front/features/auth/presentation/providers/login_provider.dart';
import 'package:descolar_front/features/auth/presentation/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:descolar_front/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'features/auth/presentation/widgets/cgu_text.dart';

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

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      key: _key,
      appBar: AppBars.homeAppBar(context, _key),
      bottomNavigationBar: DescolarNavigationBar.mainNavBar(context),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: Text('Paramètres'),
            ),
            ListTile(
              title: const Text('Conditions Générales d\'Utilisation'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CGUText(),));
              },
            ),
            ListTile(
              title: const Text(
                'Se déconnecter',
                style: TextStyle(
                  color: AppColors.error,
                ),
              ),
              onTap: () async {
                print('\nSigning out\n');
                UserRepository repository = await UserRepository.getUserRepository();
                SignOut(userRepository: repository).call();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
