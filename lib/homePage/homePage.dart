import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';
import '../Map/metro_route_finder.dart';
import '../tripDetails/tripDetails.dart';
import '../Map/metro_route_finder.dart';
import '../tripDetails/tripDetails.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<homePage> {
  MetroRouteFinder routeFinder = MetroRouteFinder(); // إنشاء نسخة من كلاس MetroRouteFinder

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
    return Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 3),
      appBar: AppBar(
        title: Text('Metro Route Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: [
            DropdownButton<String>(
              hint: Text("اختر محطة البداية"),
              value: routeFinder.startStation,
              onChanged: (newValue) {
                setState(() {
                  routeFinder.startStation = newValue;

                });
              },
              items: routeFinder.stationsname.map((station) {
                return DropdownMenuItem<String>(
                  value: station,  // تعديل المفتاح إلى 'name'
                  child: Text(station),  // تعديل المفتاح إلى 'name'
                );
              }).toList(),
            ),

            DropdownButton<String>(
              hint: Text("اختر محطة الوصول"),
              value: routeFinder.endStation,
              onChanged: (newValue) {
                setState(() {
                  routeFinder.endStation = newValue;
                });
              },
              items: routeFinder.stationsname.map((station) {
                return DropdownMenuItem<String>(
                  value: station,  // تعديل المفتاح إلى 'name'
                  child: Text(station),  // تعديل المفتاح إلى 'name'
                );
              }).toList(),
            ),

            ElevatedButton(
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
                    print("-------------------routeFinder.startStation----------------------------");
                    print(routeFinder.startStation);
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
              child: Text('عرض المسار'),
            ),
          ],
        ),
      ),
    );
  }
}
