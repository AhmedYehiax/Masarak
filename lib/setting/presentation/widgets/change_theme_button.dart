import 'package:flutter/material.dart';
import 'custom_radio_button.dart';

class ChangeThemeButton extends StatelessWidget {
  final String selectedItem;
  final void Function(String? value) onChanged;

  const ChangeThemeButton({
    super.key,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      title: 'تغيير الثيم',
      selectedItem: selectedItem,
      items: const ['Light Mode', 'Dark Mode'],
      onChanged: onChanged,
    );
  }
}
