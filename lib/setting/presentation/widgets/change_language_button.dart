import 'package:flutter/material.dart';
import 'custom_radio_button.dart';

class ChangeLanguageButton extends StatelessWidget {
  final String selectedItem;
  final void Function(String? value) onChanged;

  const ChangeLanguageButton({
    super.key,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      title: 'تغيير اللغة',
      selectedItem: selectedItem,
      items: const ['English', 'عربي'],
      onChanged: onChanged,
    );
  }
}
