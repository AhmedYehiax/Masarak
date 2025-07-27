import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0XFF007B9C);
  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color foreGroundColor = Color(0xFF989393);
  static const Color NavBarColor = Color(0xffFF8A00);

}

abstract class AppAssets {
  static const String metroLogo = 'assets/photoAndIcon/metrologo.png';
  static const String googlePlayIcon = 'assets/photoAndIcon/google_play_icon.png';
  static const String settingsIcon = 'assets/photoAndIcon/settings_icon.svg';
  static const String shareIcon = 'assets/photoAndIcon/share_icon.png';
  static const String customLine = 'assets/custom_line.svg';

  // Nav Bar Icons
}

abstract class AppTextStyles {
  static double _responsiveFontSize(BuildContext context, double fontSize) {
    final width = MediaQuery.of(context).size.width;
    double responsiveFontSize = fontSize * width / 450;
    print(responsiveFontSize);
    return responsiveFontSize.clamp(fontSize * .6, fontSize * 1.4);
  }

  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: _responsiveFontSize(context, 36),
        fontWeight: FontWeight.w400,
        color: AppColors.whiteColor,
      );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
      fontSize: _responsiveFontSize(context, 16),
      fontWeight: FontWeight.w400,
      color: AppColors.whiteColor);

  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontSize: _responsiveFontSize(context, 10),
        fontWeight: FontWeight.w400,
        color: AppColors.whiteColor,
      );
}
