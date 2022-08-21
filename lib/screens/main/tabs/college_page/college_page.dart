import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/globals.dart';
import 'package:http/http.dart' as http;
import 'package:nakshekadam/models/college_extraction_model.dart';
import 'package:nakshekadam/models/colleges_model.dart';
import 'package:nakshekadam/screens/main/tabs/college_page/college_filter_page.dart';
import 'package:nakshekadam/screens/main/tabs/college_page/college_info_card.dart';

class CollegePage extends StatefulWidget {
  const CollegePage({Key? key}) : super(key: key);

  @override
  State<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  // String? selectedSortOption = "All";
  List<CollegeModel> selectedCollege = [];
  late List<CollegeModel> colleges;
  CollegeExtractionModel collegeExtractionModel =
      CollegeExtractionModel.getModel();
  int ind = 0;
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

  late bool isLoading;

  void loadMore() {
    setState(() {
      isLoading = true;
    });
    if (colleges.length > 10) {
      ind += 10;
      selectedCollege = colleges.sublist(0, ind);
    } else {
      ind += colleges.length - ind;
      selectedCollege = colleges.sublist(0, ind);
    }
    setState(() {
      isLoading = false;
    });
  }

  late Future<List<CollegeModel>> fetchData;
  ScrollController _controller = ScrollController();
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (_controller.position.extentAfter == 0) {
        loadMore();
      }
    }
    return false;
  }

  void fetchCollegeInfo() async {
    await collegeExtractionModel.fetchCollegeInfo();
    colleges = collegeExtractionModel.allColleges;
        print("hi");
        if (colleges.length > 10) {
          ind += 10;
          selectedCollege = colleges.sublist(0, ind);
        } else {
          ind += colleges.length - ind;
          selectedCollege = colleges.sublist(0, ind);
        }
    if (mounted) {
      setState(() {});
    }
  }

  void reload() {
    if (collegeExtractionModel.checkIfEmpty()) {
      if (collegeExtractionModel.allColleges.isEmpty) {
        fetchCollegeInfo();
      }
      colleges = collegeExtractionModel.allColleges;
      print(collegeExtractionModel.allColleges);
      if (colleges.length > ind + 10) {
        ind += 10;
        selectedCollege = colleges.sublist(0, ind);
      } else {
        ind += colleges.length - ind;
        selectedCollege = colleges.sublist(0, ind);
      }
    } else {
      print(collegeExtractionModel.checkIfEmpty());
      colleges = collegeExtractionModel.filteredColleges;

      if (colleges.length > ind + 10) {
        ind += 10;
        selectedCollege = colleges.sublist(0, ind);
      } else {
        ind += colleges.length - ind;
        selectedCollege = colleges.sublist(0, ind);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    print(
        "collegeExtractionModel.allColleges : ${collegeExtractionModel.allColleges}");
    print(
        "collegeExtractionModel.filteredColleges : ${collegeExtractionModel.filteredColleges}");
    print(collegeExtractionModel.checkIfEmpty());
    if (collegeExtractionModel.allColleges.isEmpty) {
      fetchCollegeInfo();
    }
    if (collegeExtractionModel.checkIfEmpty()) {
      colleges = collegeExtractionModel.allColleges;
      print(collegeExtractionModel.allColleges);
      if (colleges.length > ind + 10) {
        ind += 10;
        selectedCollege = colleges.sublist(0, ind);
      } else {
        ind += colleges.length - ind;
        selectedCollege = colleges.sublist(0, ind);
      }
    } else {
      print("in filter");
      colleges = collegeExtractionModel.filteredColleges;

      if (colleges.length > ind + 10) {
        ind += 10;
        selectedCollege = colleges.sublist(0, ind);
      } else {
        ind += colleges.length - ind;
        selectedCollege = colleges.sublist(0, ind);
      }
    }
    // fetchData = fetchCollegeInfo();
    print("selectedCollege : $colleges");
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: screenHeight * 0.13, right: screenWidth * 0.05),
        child: FloatingActionButton(
          heroTag: "collegefilter",
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 750),
              pageBuilder: (_, __, ___) => CollegeFilterPage(
                setState: setState,
                reload: reload,
              ),
            ),
          ),
          child: const Icon(Icons.search_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
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
                    "COLLEGES",
                    style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: screenHeight * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                (selectedCollege.isNotEmpty)
                    ? MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: _handleScrollNotification,
                          child: Expanded(
                            child: ListView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: selectedCollege.length,
                              controller: _controller,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.04),
                                  child: CollegeInfoCard(
                                    collegeModel: selectedCollege[index],
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
