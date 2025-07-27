import 'dart:convert';
import 'package:flutter/services.dart';


class MetroRouteFinder  {
  List stations = [];
  Set <String> stationsname = {};
  String? startStation;
  String? endStation;
  String? nameOftransferStation;
  int? startLine;
  int? endLine;
  List<String> routeStations1 = [];
  List<String> routeStations2 = [];
  Map<String, List<int>> transferStations = {
    'العتبة': [2, 3],
    'الشهداء': [1, 2],
    'ناصر': [1, 3],
    'السادات': [1, 2]
  };
  Map <int , String> nameOfLines={
    1:"الخط الاول (حلوان, المرج الجديدة)",
    2:"الخط الثاني (المنيب , شبرا)",
    3:"الخط الثالث (عدلي منصور , محور روض الفرج)"
  };
  bool isTransferStation = false;

  Color getLineColorByName(String lineName) {
    if (lineName.contains("الخط الاول")) {
      return Color.fromARGB(255, 2, 11, 80); // Blue
    } else if (lineName.contains("الخط الثاني")) {
      return Color.fromARGB(255, 255, 0, 0); // Red
    } else if (lineName.contains("الخط الثالث")) {
      return Color.fromARGB(255, 0, 128, 0); // Green
    } else {
      return Color.fromARGB(255, 0, 0, 0); // Default Black
    }
  }

  // قراءة ملف JSON للمحطات
  Future<void> loadStations() async {
    String data = await rootBundle.loadString('assets/jsonFiles/metroLinesData.json');

    stations = jsonDecode(data);
    for(var station in stations){
      stationsname.add(station['name']);
    }
  }


  // دالة لحساب المحطات بين خطين
  void getStationsBetween(String start, String end) {
    routeStations1.clear();
    routeStations2.clear();
    isTransferStation = false;
    List<String> result = [];
    if(transferStations.containsKey(start) && transferStations.containsKey(end)){
      if(transferStations[end]![0]  == transferStations[start]![0] || transferStations[end]![0]  == transferStations[start]![1]){
        routeStations1 = getStationsBetweenSameLine(start , end, transferStations[end]![0]);
      }
      else if(transferStations[end]![1]  == transferStations[start]![1] || transferStations[end]![1]  == transferStations[start]![0]){
        routeStations1 = getStationsBetweenSameLine(start , end, transferStations[end]![1]);
      }
      else{
        searchTransferStation( start ,  end);
      }
    }
    else if (transferStations.containsKey(start)) {
      for (var station in stations) {
        if (station['name'] == end) endLine = station['line'];
      }
      if (endLine == transferStations[start]![0] || endLine == transferStations[start]![1]) {
        routeStations1 = getStationsBetweenSameLine(start , end, endLine !);
      }
      else{
        searchTransferStation( start ,  end);
      }
    }
    else if (transferStations.containsKey(end)) {
      for (var station in stations) {
        if (station['name'] == start) startLine = station['line'];
      }
      if (startLine == transferStations[end]![0] || startLine == transferStations[end]![1]) {
        routeStations1 = getStationsBetweenSameLine(start , end, startLine !);
      }
      else {
        searchTransferStation( start ,  end);
      }
    }
    else {
      // تحديد الخطين للمحطتين
      for (var station in stations) {
        if (station['name'] == start) startLine = station['line'];
        if (station['name'] == end) endLine = station['line'];
      }

      if (startLine == endLine) {
        routeStations1 = getStationsBetweenSameLine(start, end, startLine!);
      }
      else {
        searchTransferStation(start, end);
      }
    }
  }
  void searchTransferStation(String start , String end){
    // البحث عن محطة تحويل بين الخطين
    String? transferStation;
    for (var entry in transferStations.entries) {
      if (entry.value.contains(startLine) &&
          entry.value.contains(endLine)) {
        transferStation = entry.key; // محطة التحويل التي تحتوي على الخطين
        break;
      }
    }

    if (transferStation != null) {
      isTransferStation = true;
      nameOftransferStation = transferStation;
      routeStations1.addAll(
          getStationsBetweenSameLine(start, transferStation, startLine!));
      routeStations2.addAll(
          getStationsBetweenSameLine(transferStation,end, endLine!));
    }
  }
  // دالة لحساب المحطات بين محطتين على نفس الخط
  List<String> getStationsBetweenSameLine(String start, String end, int line) {
    List<String> result = [];
    bool inRange = false;
    for (var station in stations) {
      if (station['line'] == line) {
        if (station['name'] == start || station['name'] == end) {
          result.add(station['name']);
          if (inRange) break;
          inRange = !inRange;
        } else if (inRange) {
          result.add(station['name']);
        }
      }
    }

    if(result[0] == endStation) result = result.reversed.toList();
    else if (result[0] == end && end != endLine) result = result.reversed.toList();
    return result;
  }


}
