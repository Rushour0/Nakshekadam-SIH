import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/upcoming_exams_model.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/upcoming_exams_button/components.dart/upcoming_exam_info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/upcoming_exams_button/components.dart/upcoming_exams_card_button.dart';
import 'package:http/http.dart' as http;

class UpcomingExamsPage extends StatefulWidget {
  const UpcomingExamsPage({Key? key}) : super(key: key);

  @override
  State<UpcomingExamsPage> createState() => _UpcomingExamsPageState();
}

class _UpcomingExamsPageState extends State<UpcomingExamsPage> {
  List<String> sortOptions = [
    'All',
    'Today',
    'Last Week',
    'Last Month',
  ];
  String? selectedSortOption = "All";

  Future<List<UpcomingExam>> fetchUpcomingExams() async {
    var url = Uri.parse("https://tushar725mittal.me/education_streams.json");

    final response = await http.get(url);
    List<UpcomingExam> upcomingExams = [];

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      jsonDecode(response.body).forEach((jsonMap) {
        upcomingExams.add(UpcomingExam.fromMap(jsonMap));
      });
      return upcomingExams;
    } else {
      throw Exception('Failed to load upcoming exams');
    }
  }

  late Future<List<UpcomingExam>> fetchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData = fetchUpcomingExams();
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Center(
                  child: Image.asset(
                      "assets/images/upcoming_exam_images/upcoming_exams.png"),
                ),
              ),
              Center(
                child: Text(
                  "We have got all the upcoming exams covered for you. Browse through every upcoming exam updated by the MHRD here!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: screenWidth * 0.04,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: screenHeight * 0.02, top: screenHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Sort By: ",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: screenWidth * 0.05,
                        color: Colors.grey[600],
                      ),
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: COLOR_THEME["careerTile"],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.02),
                            dropdownColor: COLOR_THEME["careerTileExpanded"],
                            hint: Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                  right: screenWidth * 0.05),
                              child: const Text("Sort By"),
                            ),
                            selectedItemBuilder: (context) =>
                                sortOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.05,
                                      right: screenWidth * 0.05),
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                            }).toList(),
                            value: selectedSortOption,
                            isDense: true,
                            iconSize: screenWidth * 0.1,
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            items: sortOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedSortOption = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UpcomingExam> upcomingExams =
                        snapshot.data as List<UpcomingExam>;
                    List<UpcomingExam> selectedUpcomingExams = [];
                    DateTime today = DateTime.parse(
                        DateTime.now().toIso8601String().substring(0, 10));
                    if (selectedSortOption == null ||
                        selectedSortOption == sortOptions[0]) {
                      selectedUpcomingExams = upcomingExams;
                    } else if (selectedSortOption == sortOptions[1]) {
                      selectedUpcomingExams = upcomingExams
                          .where((upcomingExam) =>
                              upcomingExam.notifyDate == today)
                          .toList();
                    } else if (selectedSortOption == sortOptions[2]) {
                      selectedUpcomingExams = upcomingExams
                          .where((upcomingExam) =>
                              today
                                      .difference(upcomingExam.notifyDate)
                                      .inDays <=
                                  7 &&
                              today.difference(upcomingExam.notifyDate).inDays >
                                  0)
                          .toList();
                    } else if (selectedSortOption == sortOptions[3]) {
                      selectedUpcomingExams = upcomingExams
                          .where((upcomingExam) =>
                              today
                                      .difference(upcomingExam.notifyDate)
                                      .inDays <=
                                  31 &&
                              today.difference(upcomingExam.notifyDate).inDays >
                                  0)
                          .toList();
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: selectedUpcomingExams.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: UpcomingExamInfoCard(
                            upcomingExam: selectedUpcomingExams[index],
                            index: index,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
