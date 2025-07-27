import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Map/nearstStation.dart';
import '../../Map/openGoogleMap.dart';
import '../../Map/watingPageGoogleMap.dart';
import '../constants.dart';

class YourPathWidget extends StatefulWidget {
  @override
  _YourPathWidget createState() => _YourPathWidget();
}

class _YourPathWidget extends State<YourPathWidget> {
  final NearestStation _metroService = NearestStation();
    String _nearestStation = 'جاري العثور على أقرب محطة ليك';
    bool _isLoading = true; // حالة التحميل
    int maxChars = 11; // الحد الأقصى لعدد الحروف

  Future<void> _findNearestStation() async {
    try {
      String nearestStation = await _metroService.getNearestStation();
      setState(() {
        _nearestStation = nearestStation;
        _isLoading = false; // تعيين حالة التحميل إلى false بعد الانتهاء
      });
    } catch (e) {
      setState(() {
        _nearestStation = 'خطأ في تحديد الموقع: $e';
        _isLoading = false; // تعيين حالة التحميل إلى false في حالة الخطأ
      });
    }
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission(context); // طلب إذن الوصول للموقع عند فتح التطبيق
    _findNearestStation();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPathText(context),
        _buildPathButton(context),
      ],
    );
  }

  _buildPathText(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(AppAssets.orangeBackgroundShapes),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'أعرف مسارك\n',
              style: AppTextStyles.bodyMedium(context)
                  .copyWith(color: AppColors.blackColor, fontSize: 20)),
          TextSpan(
              text: '        خطوة بخطوة',
              style: AppTextStyles.bodyMedium(context)
                  .copyWith(color: AppColors.NavBarColor, fontSize: 20)),
        ]))
      ],
    );
  }

  _buildPathButton(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: 100,
          height: 50,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 10),
          margin: const EdgeInsets.only(left: 50),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // لون الظل مع الشفافية
                spreadRadius: 9, // مدى انتشار الظل
                blurRadius: 15, // مدى ضبابية الظل
                offset: Offset(0, 3), // إزاحة الظل (X:0, Y:3)
              ),
            ],
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            _nearestStation,
            style: AppTextStyles.bodyMedium(context).copyWith(color: AppColors.NavBarColor),
              softWrap: true
          ),
        ),

        Container(
          width: 80,
          height: 50,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.9),
                  // لون الظل مع الشفافية
                  spreadRadius: 5,
                  // مدى انتشار الظل
                  blurRadius: 15,
                  // مدى ضبابية الظل
                  offset: Offset(0, 3), // إزاحة الظل (X:0, Y:3)
                ),
              ],
              color: AppColors.NavBarColor,
              borderRadius: BorderRadius.circular(30)),
          child: MaterialButton(
              onPressed: () {
                // التحقق من القيم قبل الانتقال
                if (_metroService.nearestStationLat != null &&
                    _metroService.nearestStationLon != null) {
                  // الانتقال إلى صفحة الانتظار
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WaitingPage(nearestStation: _nearestStation),
                    ),
                  );
                  // فتح تطبيق خرائط جوجل
                  openGoogleMapsDirections(_metroService.nearestStationLat!,
                      _metroService.nearestStationLon!, context);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('لا يمكن فتح الخريطة.')),
                  );
                }
              },
              child: SvgPicture.asset(AppAssets.directionsIcon)),
        )
      ],
    );
  }
}
