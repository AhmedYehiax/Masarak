import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masarak/StartScreenAndNavBar/bottomNavBar2.dart'; // For rootBundle

class LinePage extends StatefulWidget {
  const LinePage({super.key});

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  bool showContainers = false;
  String? selectedLine;
  List<String> stations = [];
  bool isSecondLineSelected = false; // Flag to track if الخط الثاني is selected
  bool isThirdLineSelected = false; // Flag to track if الخط الثالث is selected

  static const String firstLine = 'الخط الأول';
  static const String secondLine = 'الخط الثاني';
  static const String thirdLine = 'الخط الثالث';

  // Helper to load stations based on selected line
  Future<void> loadStations(String line) async {
    String jsonFile;
    if (line == firstLine) {
      jsonFile = 'assets/jsonFiles/line1Data.json';
      isSecondLineSelected = false;
      isThirdLineSelected = false;
    } else if (line == secondLine) {
      jsonFile = 'assets/jsonFiles/line2Data.json';
      isSecondLineSelected = true;
      isThirdLineSelected = false;
    } else if (line == thirdLine) {
      jsonFile = 'assets/jsonFiles/line3Data.json';
      isSecondLineSelected = false;
      isThirdLineSelected = true;
    } else {
      return; // Handle the case where no valid line is selected
    }

    try {
      String jsonString = await rootBundle.loadString(jsonFile);
      List<dynamic> jsonResponse = jsonDecode(jsonString);

      setState(() {
        stations = jsonResponse.map((station) => station['name'] as String).toList();
      });
    } catch (e) {
      print("Error loading stations: $e"); // Log the error for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar2(index: 4),
      backgroundColor: const Color.fromRGBO(232, 232, 232, 1),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: 500,
              child: Image.asset('assets/images/image_allline.png', fit: BoxFit.cover),
            ),
            _buildMapSection(),
            const SizedBox(height: 20),
            _buildDropdownSection(),
            const SizedBox(height: 20),
            _buildStationList(),
          ],
        ),
      ),
    );
  }

  // Builds the map section with the button
  Widget _buildMapSection() {
    return Container(
      color: const Color.fromRGBO(3, 8, 48, 1),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilledButton(
                onPressed: () => _showMapDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  elevation: 8,
                  shadowColor: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.asset('assets/photoAndIcon/ic_map.png'),
                ),
              ),
              const SizedBox(width: 170),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'اعرف محطات\n',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    TextSpan(
                      text: 'كل خط',
                      style: TextStyle(fontSize: 18, color: Colors.orange),
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Shows the map dialog with zoom capabilities
  void _showMapDialog(BuildContext context) {showGeneralDialog(
    context: context,
    barrierDismissible: true, // يسمح بإغلاق الـ Dialog عند الضغط خارجها
    barrierLabel: '',
    pageBuilder: (context, animation1, animation2) {
      return Scaffold(
        backgroundColor: Colors.transparent, // يجعل الخلفية شفافة
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width, // عرض الشاشة بالكامل
            height: MediaQuery.of(context).size.height, // ارتفاع الشاشة بالكامل
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 15, 39), // لون الخلفية
              borderRadius: BorderRadius.circular(20), // الحواف الدائرية
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // قص المحتوى ليكون داخل الحواف الدائرية
              child: InteractiveViewer(
                panEnabled: true, // السماح بتحريك الصورة
                minScale: 0.5,    // الحد الأدنى للتكبير
                maxScale: 4.0,    // الحد الأقصى للتكبير
                child: Image.asset('assets/images/photometroLines.jpg'),
              ),
            ),
          ),
        ),
      );
    },
  );
  }

  // Builds the dropdown for selecting a metro line
  Widget _buildDropdownSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: DropdownButton<String>(
            hint: _buildDropdownHint(),
            dropdownColor: Colors.white,
            value: selectedLine,
            onChanged: (String? newValue) {
              setState(() {
                selectedLine = newValue;
                showContainers = true;
                if (selectedLine != null) {
                  loadStations(selectedLine!); // Load stations from JSON
                }
              });
            },
            items: [firstLine, secondLine, thirdLine].map<DropdownMenuItem<String>>((String value) {
              return _buildDropdownMenuItem(value);
            }).toList(),
            underline: Container(),
            icon: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  // Builds the hint for the dropdown
  Widget _buildDropdownHint() {
    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              'assets/photoAndIcon/ic_lines.png', // Left-side icon
              color: const Color.fromRGBO(134, 134, 134, 1),
            ),
          ),
          const SizedBox(width: 235.0),
          const Text(
            'اختار الخط',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  // Builds each dropdown menu item
  DropdownMenuItem<String> _buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset('assets/photoAndIcon/ic_lines.png'),
          ),
          const SizedBox(width: 210.0),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              value,
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the station list with visibility control
  Widget _buildStationList() {
    return Visibility(
      visible: showContainers,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        height: MediaQuery.of(context).size.height * 0.28,
        width: 400,
        child: ListView.separated(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    stations[index],
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(width: 10),
                  _buildStationIcon(index),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 20,
              color: Color.fromRGBO(232, 232, 232, 1),
              thickness: 10.0,
            );
          },
        ),
      ),
    );
  }

  // Builds the station icon with dynamic color
  Widget _buildStationIcon(int index) {
    Color iconColor = isSecondLineSelected
        ? Colors.red
        : isThirdLineSelected
        ? Colors.green
        : Colors.blue;

    return Icon(
      index == 0 || index == stations.length - 1
          ? Icons.circle
          : Icons.circle_outlined,
      color: iconColor,
    );
  }
}
