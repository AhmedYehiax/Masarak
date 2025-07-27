import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  final String nearestStation;

  WaitingPage({required this.nearestStation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('انتظار'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
            SizedBox(height: 20),
            Text('جاري فتح تطبيق الخرائط للذهاب إلى: $nearestStation'),
          ],
        ),
      ),
    );
  }
}
