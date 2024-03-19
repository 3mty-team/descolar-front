import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const basePath = 'assets';
  static const iconPath = '$basePath/icons';
  static const imgPath = '$basePath/images';

  static final descolarLogoSvg = SvgPicture.asset('$iconPath/descolar.svg');
  static final backIcon = SvgPicture.asset('$iconPath/back-icon.svg');
  static final settingsIcon = SvgPicture.asset('$iconPath/settings-icon.svg');
}
