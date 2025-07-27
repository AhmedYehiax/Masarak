import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:masarak/metroLines/lines.dart';
import 'package:masarak/setting/presentation/settings_view.dart';
import 'package:masarak/ticketPrice/ticket.dart';
import 'package:masarak/tripDetails/tripDetails.dart';
import 'StartScreenAndNavBar/splashScreen.dart';
import 'homePage/home_view.dart';




void main() {
  runApp(const  MasarakApp());
}

class MasarakApp extends StatelessWidget {
  const MasarakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: {
        '/Setting': (context) => SettingsView(),
        '/TripDetails': (context) => TripDetails(metroRouteFinder: null,),
        '/homePage': (context) => HomeView(),
        '/MetroLines': (context) => LinePage(),
        '/TicketPrice': (context) => TicketPage(),
        // Define your page here
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Splashscreen(),
    );
  }
}