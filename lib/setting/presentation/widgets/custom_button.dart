import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomButton({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.foreGroundColor)),
        subtitle: Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.blackColor)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {},
      ),
    );
  }
}
