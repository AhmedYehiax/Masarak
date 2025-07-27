import 'package:flutter/material.dart';

// A reusable widget function for Dropdown
Widget buildDropdown({
  String? hintText,
  List<String>? items,
  double? iconTextSpace,
  String? assetIconPath,
  double? iconPadding,
  double? dropdownWidth,
  String? currentValue,
  ValueChanged<String?>? onChanged,
  required BuildContext context
}) {
  return Container(
    width: dropdownWidth,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: DropdownButton<String>(
      hint: SizedBox(
        width: dropdownWidth, // Width for the dropdown content
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: iconPadding!),
              // Custom padding for icon
              child: Image.asset(
                assetIconPath!, // Left-side icon
                color: const Color.fromRGBO(134, 134, 134, 1),
              ),
            ),
            SizedBox(width: iconTextSpace), // Space between icon and text
            Text(hintText!,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.left),
          ],
        ),
      ),
      dropdownColor: Colors.white,
      onChanged: onChanged,
      value: currentValue,
      // Set current selected value
      items: items!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  assetIconPath!,
                  color: const Color.fromRGBO(134, 134, 134, 1),
                ),
              ),
              SizedBox(width: MediaQuery.of(context!).size.width * 0.1), // Space between icon and text
              Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ],
          ),
        );
      }).toList(),
      underline: Container(),
      // Remove the underline
      icon: const SizedBox.shrink(), // Remove the dropdown arrow icon
    ),
  );
}
