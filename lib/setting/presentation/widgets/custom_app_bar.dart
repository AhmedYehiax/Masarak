import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 2.5,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.symmetric(vertical: 49, horizontal: 28),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(55.0),
          bottomRight: Radius.circular(55.0),
        ),
      ),
    );
  }
}
