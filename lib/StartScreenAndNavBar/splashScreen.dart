import 'package:flutter/material.dart';
import 'package:masarak/homePage/homePage.dart';

import '../homePage/home_view.dart';


class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/StartScreen.png', // Replace with the path to your image
            fit: BoxFit.cover,
          ),
        ),
        // Logo at the top left
        Positioned(
          top: 30,
          left: 0,
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 251, 132, 34),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Image.asset(
              'assets/images/MasarakLogo.png', // Replace with the path to your logo
              color: Colors.white,
            ),
          ),
        ),
        // Button at the bottom center
        Positioned(
          bottom: 50,
          left: MediaQuery.of(context).size.width * 0.25,
          right: MediaQuery.of(context).size.width * 0.25,
          child: Container(
          decoration: BoxDecoration(
            boxShadow:
            const [BoxShadow(
              color: Colors.orange,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 0),
            )],
            gradient: const LinearGradient(
              colors: [Colors.yellow, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30.0),

          ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  HomeView()),
                );
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'يلا ابدأ رحلتك', // Arabic text
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}