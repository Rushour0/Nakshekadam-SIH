import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:nakshekadam/models/colleges_model.dart';
import 'package:http/http.dart' as http;

class CollegeExtractionModel {
  List<CollegeModel> allColleges = [];
  List<CollegeModel> filteredColleges = [];

  TextEditingController instituteSearchController = TextEditingController();
  TextEditingController programmeSearchController = TextEditingController();
  TextEditingController disciplineSearchController = TextEditingController();

  Future<void> fetchCollegeInfo() async {
    var url = Uri.parse("https://nakshekadam.tushar725mittal.repl.co/colleges");

    final response = await http.get(url);
    print("response : $response");
    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((jsonMap) {
        collegeExtractionModel.allColleges.add(CollegeModel.fromMap(jsonMap));
      });
    }
  }

  Future<void> filterColleges() async{
    filteredColleges.clear();
    print("https://nakshekadam.rushour0.repl.co/colleges?Name of Institution=${instituteSearchController.text}&Programme=${programmeSearchController.text}&Name of Discipline=${disciplineSearchController.text}");
    var url = Uri.parse("https://nakshekadam.rushour0.repl.co/colleges?Name of Institution=${instituteSearchController.text}&Programme=${programmeSearchController.text}&Name of Discipline=${disciplineSearchController.text}");
    final response = await http.get(url);
    print("response : $response");
    if (response.statusCode == 200) {
      jsonDecode(response.body).forEach((jsonMap) {
        collegeExtractionModel.filteredColleges.add(CollegeModel.fromMap(jsonMap));
      });
    }
  }

  bool checkIfEmpty(){
    if(instituteSearchController.text.isEmpty && programmeSearchController.text.isEmpty && disciplineSearchController.text.isEmpty){
      return true;
    }
    return false;
  }


  static final collegeExtractionModel = CollegeExtractionModel._internal();
  CollegeExtractionModel._internal();

  factory CollegeExtractionModel.getModel() => collegeExtractionModel;
}
