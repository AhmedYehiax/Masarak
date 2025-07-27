import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
Future<void> requestLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // التحقق من أن خدمات الموقع مفعلة
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location services are disabled. Please enable the services.')),
    );
    return;
  }

  // التحقق من إذن الوصول إلى الموقع
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are denied.')),
      );
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location permissions are permanently denied. We cannot request permissions.')),
    );
    return;
  }
}

Future<void> openGoogleMapsDirections(double latitude, double longitude,BuildContext context) async {
  try {
    // التحقق من إذن الموقع وخدمات الموقع
    await requestLocationPermission(context);

    // الحصول على موقع الهاتف الحالي
    Position position = await Geolocator.getCurrentPosition();

    // بناء الرابط باستخدام إحداثيات الموقع الحالي
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=$latitude,$longitude&travelmode=driving';
    final Uri url = Uri.parse(googleMapsUrl);

    // استخدام canLaunch و launch بشكل صحيح
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault); // تغيير هنا
    } else {
      // محاولة استخدام تطبيق آخر للخرائط
      print('Could not open the map. Trying with another app.');
      final Uri alternativeUrl = Uri.parse('geo:$latitude,$longitude?q=$latitude,$longitude');
      if (await canLaunchUrl(alternativeUrl)) {
        await launchUrl(alternativeUrl, mode: LaunchMode.platformDefault); // تغيير هنا
      } else {
        print('No map application found.');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
