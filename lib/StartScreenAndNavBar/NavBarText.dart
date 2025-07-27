import 'package:flutter/material.dart';

class NavBarText extends StatelessWidget {
  const NavBarText({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على عرض الشاشة
    double screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // مساحة ديناميكية على اليسار
          SizedBox(width: screenWidth * 0.065), // مساحة ديناميكية على اليسار
          const Text(
            'الاعدادات',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: screenWidth * 0.09), // مسافة ديناميكية بين النصوص
          const Text(
            'مسارك',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: screenWidth * 0.11), // مسافة ديناميكية بين النصوص
          const Text(
            'الرئيسية',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: screenWidth * 0.1), // مسافة ديناميكية بين النصوص
          const Text(
            'الخريطة',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: screenWidth * 0.08), // مسافة ديناميكية بين النصوص
          const Text(
            'سعر التذكرة',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          // مساحة ديناميكية على اليمين
          SizedBox(width: screenWidth * 0.009), // مساحة ديناميكية على اليمين
        ],
      ),
    );
  }
}
