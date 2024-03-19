import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const basePath = 'assets';
  static const iconPath = '$basePath/icons';
  static const imgPath = '$basePath/images';

  static final descolarLogoSvg = SvgPicture.asset('$iconPath/descolar.svg');
  static final homeIcon = SvgPicture.asset('$iconPath/home_icon.svg');
  static final messageIcon = SvgPicture.asset('$iconPath/message_icon.svg');
  static final newPostIcon = SvgPicture.asset('$iconPath/new_post_icon.svg');
  static final profilIcon = SvgPicture.asset('$iconPath/profil_icon.svg');
  static final searchIcon = SvgPicture.asset('$iconPath/search_icon.svg');
  static const backgroundNav = AssetImage('$imgPath/BG.png');
}
