import 'package:flutter/material.dart';
import '../StartScreenAndNavBar/bottomNavBar2.dart';
import '../homePage/home_view.dart';

class NoDirection extends StatelessWidget {
  const NoDirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 2),
      backgroundColor: Color.fromARGB(255, 248, 248, 230),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/masar_image.png",
              width: 435,
              height: 435),
          Container(
              color: Color.fromARGB(255, 3, 8, 48),
              width: 370,
              height: 134,
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 8,
                    child: Text("لم يتم اختيار اي وجهة", style: TextStyle(color: Colors.white, fontSize: 23),),
                  ),
                  Positioned(
                      left: 35,
                      top: 10,
                      child: Image.asset("assets/images/masar_icon.png", width: 40, height: 40)
                  ),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 330,
                          height: 54,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 253, 147, 45),
                                    spreadRadius: 5,
                                    blurRadius: 20,
                                    offset: Offset(0, 0)
                                )
                              ]
                          ),
                          child: FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 253, 147, 45)
                              ),
                              onPressed: (){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ),
                                );
                              },
                              child: Text("روح اختار", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),)),
                        ),
                      )
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
