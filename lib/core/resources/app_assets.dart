import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const basePath = 'assets';
  static const iconPath = '$basePath/icons';
  static const imgPath = '$basePath/images';

  static final descolarLogoSvg = SvgPicture.asset('$iconPath/descolar.svg');
  static final splashScreenLogo = Container(
    height: 100,
    width: 100,
    color: Colors.transparent,
    child:  SvgPicture.asset('$iconPath/descolar.svg'),
  );
  
}
