import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blue,
      height: MediaQuery.of(context).size.height*0.47,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Image.asset(AppAssets.metroBackgroundImage,
                width: double.infinity, fit: BoxFit.fill),
          ),
          Positioned(
            top: 30,
            left: 33,
            right: 33,
            child: Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.NavBarColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5), // اللون البرتقالي مع الشفافية
                    spreadRadius: 8, // مدى انتشار الظل
                    blurRadius: 20, // مدى ضبابية الظل
                    offset: Offset(0, 3), // إزاحة الظل (X:0, Y:3)
                  ),
                ],
// Orange background
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'اهلا وسهلا بيك في مسارك',
                        style: AppTextStyles.bodySmall(context),
                      ),
                      const SizedBox(
                          height: 4), // Spacing between the two texts
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        child: Text(
                          'نتمني ليك رحلة سعيدة',
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: AppColors.NavBarColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      left: 0,
                      child: SvgPicture.asset(AppAssets.welcomeIcon)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}