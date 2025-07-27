import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.textDesc, required this.iconDesc, required this.classDetail, required this.classNum});
  final String textDesc;
  final IconData iconDesc;
  final String classDetail;
  final String classNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: MediaQuery.of(context).size.width * 0.3174,
      decoration: BoxDecoration(
          color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(textDesc, style: TextStyle(color: Colors.grey, fontSize: 27)),
              Icon(iconDesc, color: Colors.grey, size: 25),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(classDetail, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              Text(classNum, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
    );
  }
}
