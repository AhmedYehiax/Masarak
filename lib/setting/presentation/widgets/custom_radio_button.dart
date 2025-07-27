import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final String selectedItem;
  final List<String> items;
  final void Function(String? value)? onChanged;

  const CustomRadioButton({
    super.key,
    required this.title,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
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
                .copyWith(color: Colors.black)),
        subtitle: Text(selectedItem,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return _ShowBottomSheetBody(
                title: title,
                items: items,
                selectedItem: selectedItem,
                onChanged: onChanged,
              );
            },
          );
        },
      ),
    );
  }
}

class _ShowBottomSheetBody extends StatefulWidget {
  const _ShowBottomSheetBody({
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  final String title;
  final List<String> items;
  final String selectedItem;
  final void Function(String? value)? onChanged;

  @override
  State<_ShowBottomSheetBody> createState() => _ShowBottomSheetBodyState();
}

class _ShowBottomSheetBodyState extends State<_ShowBottomSheetBody> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(widget.title,
              style: AppTextStyles.bodyLarge(context)
                  .copyWith(color: AppColors.blackColor)),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                value: widget.items[index],
                groupValue: _selectedItem,
                activeColor: AppColors.primaryColor,
                title: Text(widget.items[index]),
                onChanged: (String? value) {
                  setState(() {
                    _selectedItem = value!;
                  });
                  widget.onChanged?.call(value);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
