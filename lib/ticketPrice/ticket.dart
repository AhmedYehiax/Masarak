import 'package:flutter/material.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart';
import '../Map/metro_route_finder.dart';
import 'dropdown.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  MetroRouteFinder routeFinder = MetroRouteFinder();
  bool showContainers = false;
  String? fromPlace;
  String? toPlace;
  String? numofpeople;
  String fareMessage = '';
  int stationCount = 0;
  int time = 0;

  @override
  void initState() {
    super.initState();
    loadMetroStations();
  }

  Future<void> loadMetroStations() async {
    await routeFinder.loadStations();
    setState(() {}); // تحديث الواجهة بعد تحميل المحطات
  }

  void calculateFare() {
    if (fromPlace == null || toPlace == null || numofpeople == null || toPlace == fromPlace) {
      setState(() {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("خطأ"),
              content: Text("Invalid selection. Please select valid stations and number of people."),
              actions: [
                TextButton(
                  child: Text("موافق"),
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق الرسالة
                  },
                ),
              ],
            );
          },
        );
        fareMessage = 'Invalid selection. Please select valid stations and number of people.';
      });
      return;
    }
    routeFinder.getStationsBetween(fromPlace!, toPlace!);

    int fromIndex = routeFinder.stationsname.toList().indexOf(fromPlace!);
    int toIndex = routeFinder.stationsname.toList().indexOf(toPlace!);

    if (fromIndex == -1 || toIndex == -1) {
      setState(() {
        fareMessage = 'Invalid selection. Please select valid stations.';
      });
      return;
    }

    int calculatedStationCount = routeFinder.routeStations1.length + routeFinder.routeStations2.length;
    int price;
    if (calculatedStationCount == 0) {
      setState(() {
        fareMessage = 'Please select different stations.';
        stationCount = 0;
        time = 0;
      });
      return;
    }

    // Determine the price based on the number of stations
    if (calculatedStationCount <= 9) {
      price = 8;
    } else if (calculatedStationCount <= 16) {
      price = 10;
    } else if (calculatedStationCount <= 23) {
      price = 15;
    } else {
      price = 20;
    }

    // Calculate the total price for the number of people
    int totalPrice = price * int.parse(numofpeople!);

    setState(() {
      fareMessage = '$totalPrice جنيه'; // Display the total price
      stationCount = calculatedStationCount;
      time = (stationCount * 2).round(); // Update the time estimation
    });
    showContainers = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 5),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 500,
              left: 0,
              right: 0,
              child: Image.asset(
                  'assets/images/image_inticket.png', fit: BoxFit.fill),
            ),
            Positioned(
              right: 10,
              left: 10,
              top: 100,
              bottom: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(232, 232, 232, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  // قم بإزالة ارتفاع الحاوية
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // اجعل الحاوية تأخذ الحجم المطلوب
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 7, 27, 97),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.asset('assets/photoAndIcon/ic_ticket.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'حساب سعر التذكرة',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 7, 27, 97),
                            fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      routeFinder.stationsname.isNotEmpty
                          ? buildDropdown(
                        context: context,
                        hintText: "من",
                        items: routeFinder.stationsname.toList(),
                        iconTextSpace: 100.0,
                        assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                        iconPadding: 10.0,
                        dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                        currentValue: fromPlace,
                        onChanged: (String? newValue) {
                          setState(() {
                            fromPlace = newValue;
                          });
                        },
                      )
                          : const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      routeFinder.stationsname.isNotEmpty
                          ? buildDropdown(
                        context: context,
                        hintText: "الي",
                        items: routeFinder.stationsname.toList(),
                        iconTextSpace: 300.0,
                        assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                        iconPadding: 10.0,
                        dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                        currentValue: toPlace,
                        onChanged: (String? newValue) {
                          setState(() {
                            toPlace = newValue;
                          });
                        },
                      )
                          : const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      buildDropdown(
                        context: context,
                        hintText: "عداد الافراد",
                        items: ['1', '2', '3', '4'],
                        iconTextSpace: 220.0,
                        assetIconPath: 'assets/photoAndIcon/ic_lines.png',
                        iconPadding: 10.0,
                        dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                        currentValue: numofpeople,
                        onChanged: (String? newValue) {
                          setState(() {
                            numofpeople = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      FilledButton(
                        onPressed: () {
                          calculateFare(); // Recalculate the fare
                          setState(() {});
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(const Size(370, 60)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 7, 27, 97)),
                          elevation: MaterialStateProperty.all(10),
                          overlayColor: MaterialStateProperty.all(Color.fromARGB(
                              255, 0, 0, 0)),
                          shadowColor: MaterialStateProperty.all(Color.fromARGB(
                              255, 0, 0, 0)),
                        ),
                        child: const Text('احسب', style: TextStyle(fontSize: 25)),
                      ),
                      Visibility(
                        visible: showContainers,
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height: 75,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '$stationCount \nمحطات',
                                        style: const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      Image.asset(
                                          'assets/photoAndIcon/ic-metro.png'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  height: 75,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '$time \nدقائق',
                                        style: const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                      Icon(Icons.timer_sharp),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'المبلغ اللي هتدفعه هو ',
                                            style: TextStyle(fontSize: 20), // ستايل النص الأساسي
                                          ),
                                          TextSpan(
                                            text: '${fareMessage}', // النص اللي عايز تغيّر لونه
                                            style: TextStyle(color: Color.fromARGB(
                                                255, 255, 141, 0),
                                                 fontSize: 25), // ستايل النص المتغير
                                          ),
                                        ],
                                      ),
                                    )  ,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
