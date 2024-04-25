import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  static const basePath = 'assets';
  static const iconPath = '$basePath/icons';
  static const imgPath = '$basePath/images';

  static const double navbarIconSize = 36;

  static final descolarLogoSvg = SvgPicture.asset('$iconPath/descolar.svg');
  static final sampleProfilIcon = SvgPicture.asset('$imgPath/sample_profil_icon.svg');
  static final homeIcon = SvgPicture.asset(
    '$iconPath/home_icon.svg',
    height: navbarIconSize,
    width: navbarIconSize,
    fit: BoxFit.scaleDown,
  );
  static final messageIcon = SvgPicture.asset(
    '$iconPath/message_icon.svg',
    height: navbarIconSize,
    width: navbarIconSize,
    fit: BoxFit.scaleDown,
  );
  static final newPostIcon = SvgPicture.asset(
    '$iconPath/new_post_icon.svg',
    height: navbarIconSize,
    width: navbarIconSize,
    fit: BoxFit.scaleDown,
  );
  static final profilIcon = SvgPicture.asset(
    '$iconPath/profil_icon.svg',
    height: navbarIconSize,
    width: navbarIconSize,
    fit: BoxFit.scaleDown,
  );
  static final searchIcon = SvgPicture.asset(
    '$iconPath/search_icon.svg',
    height: navbarIconSize,
    width: navbarIconSize,
    fit: BoxFit.scaleDown,
  );
  static final backgroundNav = SvgPicture.asset('$imgPath/backgroundNavBar.svg');
  static final settingsIcon = SvgPicture.asset('$iconPath/settings-icon.svg');
  static final backIcon = SvgPicture.asset('$iconPath/back-icon.svg');
  static final closeIcon = SvgPicture.asset('$iconPath/close_icon.svg');
  static final addImageIcon = SvgPicture.asset('$iconPath/add_image_icon.svg');
  static final commentIcon = SvgPicture.asset('$iconPath/comment_icon.svg');
  static final likeIcon = SvgPicture.asset('$iconPath/like_icon.svg');
  static final likedIcon = SvgPicture.asset('$iconPath/liked_icon.svg');
  static final shareIcon = SvgPicture.asset('$iconPath/share_icon.svg');
  static final optionsIcon = SvgPicture.asset('$iconPath/options_icon.svg');
}
