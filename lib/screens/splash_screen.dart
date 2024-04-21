import 'package:descolar_front/core/errors/failure.dart';
import 'package:descolar_front/core/resources/app_assets.dart';
import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:descolar_front/features/auth/business/entities/user_entity.dart';
import 'package:descolar_front/features/auth/business/repositories/user_repository.dart';
import 'package:descolar_front/features/auth/business/usecases/get_remember_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  static const double _logoSize = 150;

  static var logo = Container(
    height: _logoSize,
    width: _logoSize,
    color: Colors.transparent,
    child: SvgPicture.asset('${AppAssets.iconPath}/descolar.svg'),
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );

    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () async {
        // Remember me
        UserRepository userRepository = await UserRepository.getUserRepository();
        final failureOrUser = await GetRememberUser(userRepository: userRepository).call();
        failureOrUser.fold(
          (Failure failure) {
            if (failure is CacheFailure) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          (UserEntity? user) {
            // If remember user in cache, go home
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/home');
            }
            // else go login
            else {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext contet) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(opacity: value, child: child);
              },
              child: logo,
            ),
          ],
        ),
      ),
    );
  }
}
