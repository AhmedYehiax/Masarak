import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar.dart';
import 'package:masarak/StartScreenAndNavBar/NavBarText.dart';

class BottomNavBar2 extends StatefulWidget {
  const BottomNavBar2({super.key, required this.index});
  final int index;

  @override
  State<BottomNavBar2> createState() => _BottomNavBar2State();
}

class _BottomNavBar2State extends State<BottomNavBar2> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index; // Correct way to initialize the index
  }

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery للحصول على عرض الشاشة
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: screenWidth * 0.03,
          right: screenWidth * 0.03,
          top: 40,
          child: Container(
            height: screenHeight * 0.1, // 10% من ارتفاع الشاشة
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 9, 15, 39),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: NavBarText(),
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: BottomNavBar(index: index),
        ),
      ],
    );
  }
}