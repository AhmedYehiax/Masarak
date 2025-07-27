import 'package:flutter/material.dart';
import 'package:masarak/Map/watingPageGoogleMap.dart';
import 'package:masarak/Map/nearstStation.dart';
import 'package:masarak/Map/openGoogleMap.dart';


class RouteAndMapSection extends StatefulWidget {
  @override
  RouteAndMapSectionState createState() => RouteAndMapSectionState();
}

class RouteAndMapSectionState extends State<RouteAndMapSection> {
  final NearestStation _metroService = NearestStation();
  String _nearestStation = 'جاري العثور على أقرب محطة ليك';
  bool _isLoading = true; // حالة التحميل

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Directions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_nearestStation),
            SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.map, color: Colors.blue, size: 50.0),
                onPressed: () {
                  // التحقق من القيم قبل الانتقال
                  if (_metroService.nearestStationLat != null && _metroService.nearestStationLon != null) {
                    // الانتقال إلى صفحة الانتظار
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WaitingPage(nearestStation: _nearestStation),
                      ),
                    );
                    // فتح تطبيق خرائط جوجل
                    openGoogleMapsDirections(
                      _metroService.nearestStationLat!,
                      _metroService.nearestStationLon!,
                      context
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('لا يمكن فتح الخريطة.')),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }



}
