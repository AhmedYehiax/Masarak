import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import 'white_box.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.settingsIcon,
                    height: 36,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'الإعدادات',
                    style: AppTextStyles.bodyLarge(context), // Use TextTheme
                  ),
                ],
              ),
              const Expanded(child: SingleChildScrollView(child: WhiteBox())),
            ],
          ),
        ),
      ),
    );
  }
}
