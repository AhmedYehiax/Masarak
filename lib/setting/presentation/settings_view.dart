import 'package:flutter/material.dart';

import '../../StartScreenAndNavBar/bottomNavBar2.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 1),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child:  const Stack(
              children: [
                CustomAppBar(),
                SettingsViewBody(),
              ],
            ),
          ),

        ],
      ),
    );


  }
}
