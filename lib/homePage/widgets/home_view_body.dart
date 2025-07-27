import 'package:flutter/material.dart';

import '../constants.dart';
import 'from_to_widget.dart';
import 'welcome_widget.dart';
import 'your_path_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // 1- Welcome Part
          const WelcomeWidget(),
      
          // 3- Know your path part
          YourPathWidget(),
      
          // 4- From To part
           FromToWidget(),
      
          
        ],
      ),
    );
  }
}
