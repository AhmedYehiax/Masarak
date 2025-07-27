import 'package:flutter/material.dart';
import 'package:masarak/Map/metro_route_finder.dart';
import '../../tripDetails/tripDetails.dart';
import '../constants.dart';

class FromToActionButton extends StatelessWidget {
  final MetroRouteFinder routeFinder;

  FromToActionButton({super.key, required this.routeFinder});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.NavBarColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.6), // اللون البرتقالي مع الشفافية
            spreadRadius: 8, // مدى انتشار الظل
            blurRadius: 15, // مدى ضبابية الظل
            offset: Offset(0, 3), // إزاحة الظل (X:0, Y:3)
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          if (routeFinder.startStation != null && routeFinder.endStation != null) {
            if (routeFinder.startStation == routeFinder.endStation) {
              // عرض رسالة خطأ إذا كانت محطة البداية هي نفسها محطة النهاية
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("خطأ"),
                    content: Text("محطة البداية لا يمكن أن تكون هي نفسها محطة النهاية!"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("حسناً"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              // حساب المسار
              routeFinder.getStationsBetween(routeFinder.startStation!, routeFinder.endStation!);

              // الانتقال إلى صفحة عرض التفاصيل
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripDetails(
                    metroRouteFinder: routeFinder,
                  ),
                ),
              );
            }
          } else {
            // عرض رسالة خطأ إذا لم يتم اختيار المحطات
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("خطأ"),
                  content: Text("يرجى اختيار محطة البداية ومحطة النهاية!"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("حسناً"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'عرفني',
          style: AppTextStyles.bodyMedium(context),
        ),
      ),
    );
  }
}
