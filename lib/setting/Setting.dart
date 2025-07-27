// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:masarak/homePage/homePage.dart';
// import 'package:masarak/metroLines/lines.dart';
// import 'package:masarak/ticketPrice/ticket.dart';
// import 'package:masarak/tripDetails/tripDetails.dart';
//
// import '../homePage/home_view.dart';
// import 'presentation/settings_view.dart';
//
//
//
// class Setting extends StatelessWidget {
//   const Setting({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//
//         // Set Arabic as the only locale
//         locale: const Locale('ar'),
//         supportedLocales: const [
//           Locale('ar'),
//           Locale('en'),
//         ],
//         localizationsDelegates: const [
//           GlobalMaterialLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//         ],
//         home: const SettingsView(),
//         routes: {
//           '/Setting': (context) => Setting(),
//           '/TripDetails': (context) => TripDetails(metroRouteFinder: null,),
//           '/homePage': (context) => HomeView(),
//           '/MetroLines': (context) => LinePage(),
//           '/TicketPrice': (context) => TicketPage(),
//       },
//     );
//   }
// }
