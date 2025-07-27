import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../Map/metro_route_finder.dart';
import '../constants.dart';

class FromToContainer extends StatefulWidget {
  final MetroRouteFinder routeFinder;

  FromToContainer({super.key, required this.routeFinder});

  @override
  State<FromToContainer> createState() => _FromToContainerState();
}

class _FromToContainerState extends State<FromToContainer> {
  void _swapStations() {
    setState(() {
      // تبديل محطة البداية والنهاية
      final temp = widget.routeFinder.startStation;
      widget.routeFinder.startStation = widget.routeFinder.endStation;
      widget.routeFinder.endStation = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 9,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _FromToField(
            label: 'من',
            hintText: "اختر محطة البداية",
            value: widget.routeFinder.startStation,
            onChanged: (newValue) {
              setState(() {
                widget.routeFinder.startStation = newValue;
              });
            },
            stations: widget.routeFinder.stationsname.toList(),
          ),
          SizedBox(height: 8),

          // زر تبديل المحطات
          IconButton(
            icon: Icon(Icons.swap_vert), // أيقونة تبديل
            onPressed: _swapStations, // استدعاء الدالة لتبديل المحطات
          ),

          SizedBox(height: 8),
          _FromToField(
            label: 'إلى',
            hintText: "اختر محطة الوصول",
            value: widget.routeFinder.endStation,
            onChanged: (newValue) {
              setState(() {
                widget.routeFinder.endStation = newValue;
              });
            },
            stations: widget.routeFinder.stationsname.toList(),
          ),
        ],
      ),
    );
  }
}


class _FromToField extends StatelessWidget {
  final String label;
  final String? value;
  final String hintText;
  final List<String> stations;
  final ValueChanged<String?>? onChanged;

  const _FromToField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.onChanged,
    required this.stations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.homeBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TypeAheadFormField<String?>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: TextEditingController(text: value), // Display selected station
          decoration: InputDecoration(
            hintText: value != null && value!.isNotEmpty ? value : hintText, // Show selected station if exists
            border: InputBorder.none,
          ),
        ),
        suggestionsCallback: (pattern) {
          return stations.where((station) =>
              station.toLowerCase().contains(pattern.toLowerCase()));
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion ?? ''),
          );
        },
        onSuggestionSelected: (suggestion) {
          onChanged?.call(suggestion);
        },
        noItemsFoundBuilder: (context) => SizedBox(
          height: 50,
          child: Center(child: Text('لا توجد محطات مطابقة')),
        ),
        getImmediateSuggestions: true,
        hideOnEmpty: true,
        hideSuggestionsOnKeyboardHide: false,
      ),
    );
  }
}