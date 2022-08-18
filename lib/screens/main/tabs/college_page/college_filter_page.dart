import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/college_extraction_model.dart';
import 'package:nakshekadam/models/colleges_model.dart';
import 'package:nakshekadam/screens/main/tabs/college_page/college_info_card.dart';

class CollegeFilterPage extends StatefulWidget {
  const CollegeFilterPage({
    Key? key,
    required this.setState,
    required this.reload,
  }) : super(key: key);
  final Function setState;
  final Function reload;

  @override
  State<CollegeFilterPage> createState() => _CollegeFilterPageState();
}

class _CollegeFilterPageState extends State<CollegeFilterPage> {
  // String? selectedSortOption = "All";
  CollegeExtractionModel collegeExtractionModel = CollegeExtractionModel.getModel();
  late TextEditingController _instituteSearchController;
  late TextEditingController _programmeSearchController;
  late TextEditingController _disciplineSearchController;
  // List<CollegeModel> selectedCollege = [];
  // List<CollegeModel> colleges = [];
  int ind = 0;
  bool isLoading = false;
  // Future<void> fetchCollegeInfo() async {
  //   var url = Uri.parse("https://nakshekadam.tushar725mittal.repl.co/colleges");

  //   final response = await http.get(url);
  //   print("response : $response");
  //   if (response.statusCode == 200) {
  //     print(jsonDecode(response.body));
  //     jsonDecode(response.body).forEach((jsonMap) {
  //       colleges.add(CollegeModel.fromMap(jsonMap));
  //     });
  //     if (mounted) {
  //       setState(() {
  //         ind = 10;
  //         selectedCollege = colleges.sublist(0, ind);
  //       });
  //     }
  //   } else {
  //     throw Exception('Failed to load upcoming exams');
  //   }
  // }

  // late bool isLoading;

  // void loadMore() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   ind += 10;
  //   selectedCollege = colleges.sublist(0, ind);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // late Future<List<CollegeModel>> fetchData;
  // ScrollController _controller = ScrollController();
  // bool _handleScrollNotification(ScrollNotification notification) {
  //   if (notification is ScrollEndNotification) {
  //     if (_controller.position.extentAfter == 0) {
  //       loadMore();
  //     }
  //   }
  //   return false;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _instituteSearchController = collegeExtractionModel.instituteSearchController;
    _disciplineSearchController = collegeExtractionModel.disciplineSearchController;
    _programmeSearchController = collegeExtractionModel.programmeSearchController;
    // isLoading = false;
    // fetchCollegeInfo();
    // fetchData = fetchCollegeInfo();
  }

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];
    TextFormField _searchTextFormField(String hintText, String labelText,
            TextEditingController controller) =>
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            hintStyle: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
          ),
        );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () async{
          setState(() {
            isLoading = true;
          });
          if(!collegeExtractionModel.checkIfEmpty()){
            await collegeExtractionModel.filterColleges();
          }
          widget.setState((){
            print("in set state");
            widget.reload();
          });
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pop(context);
        },
        child: const Icon(Icons.filter_alt_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: (!isLoading)?SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: screenHeight * 0.1, top: screenHeight * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: Text(
                      "Apply Filters",
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: screenHeight * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                    child: _searchTextFormField("Name of Institute",
                        "Institute", _instituteSearchController),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                    child: _searchTextFormField("Name of Discipline",
                        "Discipline", _disciplineSearchController),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                    child: _searchTextFormField("Name of Programme",
                        "Programme", _programmeSearchController),
                  ),
                ],
              ),
            ),
          ),
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
