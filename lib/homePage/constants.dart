import 'package:flutter/material.dart';

// Home Page
abstract class AppAssets {
  static const String welcomeIcon = 'assets/photoAndIcon/welcome_icon.svg';
  static const String metroBackgroundImage = 'assets/photoAndIcon/metro_background.png';
  static const String directionsIcon = 'assets/photoAndIcon/directions_icon.svg';
  static const String orangeBackgroundShapes =
      'assets/photoAndIcon/orange_background_shapes.svg';
}

abstract class AppColors {
  static const Color primaryColor = Color(0XFF007B9C);
  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color foreGroundColor = Color(0xFF989393);
  static const Color NavBarColor = Color(0xffff9735);
  static const Color homeBackgroundColor = Color(0xFFEAEBEB);
}


abstract class AppTextStyles {
  static double _responsiveFontSize(BuildContext context, double fontSize) {
    final width = MediaQuery.of(context).size.width;
    double responsiveFontSize = fontSize * width / 450;
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
