import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';


class NearestStation {

  String? nearestStationName;
  double? nearestStationLat;
  double? nearestStationLon;

  Future<String> getNearestStation() async {
    // احصل على الموقع الحالي للمستخدم
    Position position = await determinePosition();
    double userLat = position.latitude;
    double userLon = position.longitude;
   String data = await rootBundle.loadString('assets/jsonFiles/metroLinesData.json');
    final List<dynamic> stationData = json.decode(data);

    double shortestDistanceSquared = double.infinity;

    for (var station in stationData) {
      double stationLat = station['latitude'];
      double stationLon = station['longitude'];
      String stationName = station['name'];

      // حساب المسافة بين موقع المستخدم ومحطة المترو الحالية
      double distanceSquared = calculateDistanceSquared(userLat, userLon, stationLat, stationLon);

      if (distanceSquared < shortestDistanceSquared) {
        shortestDistanceSquared = distanceSquared;
        nearestStationName = stationName;
        nearestStationLat = stationLat;
        nearestStationLon = stationLon;
      }
    }
    // print("-------------------------------------------");
    // print(nearestStationLon);
    // print(nearestStationLat);
    return nearestStationName ?? 'لا توجد محطة قريبة.';
  }

  double calculateDistanceSquared(double lat1, double lon1, double lat2, double lon2) {
    return (lat1 - lat2) * (lat1 - lat2) + (lon1 - lon2) * (lon1 - lon2);
  }


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // تحقق من تمكين خدمة الموقع
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'خدمات الموقع غير مفعلة';
    }

    // تحقق من صلاحيات الوصول للموقع
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'صلاحيات الموقع مرفوضة';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'صلاحيات الموقع مرفوضة بشكل دائم';
    }

    // احصل على الموقع الحالي
    return await Geolocator.getCurrentPosition();
  }


}
