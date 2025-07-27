import 'package:flutter/material.dart';

import '../../Map/metro_route_finder.dart';
import 'from_to_action_button.dart';
import 'from_to_container.dart';

class FromToWidget extends StatefulWidget {
  const FromToWidget({super.key});

  @override
  State<FromToWidget> createState() => _FromToWidgetState();
}

class _FromToWidgetState extends State<FromToWidget> {
  MetroRouteFinder routeFinder =
      MetroRouteFinder(); // إنشاء نسخة من كلاس MetroRouteFinder
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMetroStations();
  }

  Future<void> loadMetroStations() async {
    await routeFinder.loadStations();
    setState(() {}); // تحديث الواجهة بعد تحميل المحطات
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 1.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -10), // رفع العنصر الأول للأعلى
              child: FromToContainer(routeFinder: routeFinder,),
            ),
            Transform.translate(
              offset: const Offset(0, 70), // رفع العنصر الأول للأعلى
              child: FromToActionButton(routeFinder: routeFinder,),
            ),

          ],
        ),
      ),
    );
  }

}
