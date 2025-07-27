import 'package:flutter/material.dart';
import '../StartScreenAndNavBar/bottomNavBar2.dart';
import 'constants.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar2(index: 3),
        backgroundColor: AppColors.homeBackgroundColor,
        body: const HomeViewBody(),
      ),
    );
  }
}
