import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/customPageRouter.dart';
import 'package:nakshekadam/common_widgets/enums/test_enum.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/test_marks_model.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/reasoning_card.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/testDialogBox.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class TakeTest extends StatefulWidget {
  const TakeTest({
    Key? key,
    required this.testName,
  }) : super(key: key);
  final String testName;

  @override
  State<TakeTest> createState() => _TakeTestState();
}

class _TakeTestState extends State<TakeTest> {
  List<Map<String, dynamic>> personalityTestQuestions = [];
  TextEditingController answerEditor = TextEditingController(text: "");
  TestMarksDetails testMarksDetails = TestMarksDetails.getModel();
  late final int totalLength;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/jsons/${widget.testName}.json');
    final data = await json.decode(response);
    data["data"].forEach((element) {
      String tempQuestion = element["question"];
      List<String> tempOptions = [];
      element["options"].forEach((element) {
        tempOptions.add(element);
      });
      double tempWeightage = element["weightage"];
      Map<String, dynamic> tempValue = {};
      if (element["value"].runtimeType == List) {
        print(element["value"].asMap());

        tempValue = (element["value"] as List).asMap().map(
          (key, value) {
            return MapEntry(key.toString(), value);
          },
        );
      } else {
        element["value"].forEach((key, value) {
          List<dynamic> temp = [];
          print(value.runtimeType);
          value.forEach((element) {
            temp.add(element);
          });
          tempValue[key] = temp;
        });
      }
      personalityTestQuestions.add({
        "question": tempQuestion,
        "options": tempOptions,
        "weightage": tempWeightage,
        "value": tempValue,
      });
    });
    totalLength = personalityTestQuestions.length;
    setState(() {
      print("abc : ${personalityTestQuestions.last}");
    });
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

    void increaseMarks(double weightage, TestEnum testEnum) {
      if (testEnum == TestEnum.STEM) {
        testMarksDetails.stem += weightage;
      } else if (testEnum == TestEnum.ARTS) {
        testMarksDetails.creative_argumentative_studies += weightage;
      } else if (testEnum == TestEnum.COMMERCE) {
        testMarksDetails.commerce_management += weightage;
      } else if (testEnum == TestEnum.DEFENSE) {
        testMarksDetails.defense += weightage;
      } else if (testEnum == TestEnum.JOBS) {
        testMarksDetails.jobs_as_soon_as_possible += weightage;
      } else if (testEnum == TestEnum.VOCATIONAL) {
        testMarksDetails.vocational_courses += weightage;
      } else if (testEnum == TestEnum.CIVIL) {
        testMarksDetails.civil_services += weightage;
      }
    }

    String nextTestName() {
      if (widget.testName == "Personality Test") {
        return "Background Test";
      } else if (widget.testName == "Background Test") {
        return "Interest Test";
      }
      return "Result";
    }

    void saveResultAndEmptyModel() {
      if (widget.testName == "Personality Test") {
        testMarksDetails.personality_marks = {
          "stem": testMarksDetails.stem,
          "commerce & management": testMarksDetails.commerce_management,
          "creative & argumentative studies":
              testMarksDetails.creative_argumentative_studies,
          "civil services": testMarksDetails.civil_services,
          "defense": testMarksDetails.defense,
          "vocational courses": testMarksDetails.vocational_courses,
          "jobs as soon as possible": testMarksDetails.jobs_as_soon_as_possible,
        };
      } else if (widget.testName == "Background Test") {
        testMarksDetails.background_test = {
          "stem": testMarksDetails.stem,
          "commerce & management": testMarksDetails.commerce_management,
          "creative & argumentative studies":
              testMarksDetails.creative_argumentative_studies,
          "civil services": testMarksDetails.civil_services,
          "defense": testMarksDetails.defense,
          "vocational courses": testMarksDetails.vocational_courses,
          "jobs as soon as possible": testMarksDetails.jobs_as_soon_as_possible,
        };
      } else if (widget.testName == "Interest Test") {
        testMarksDetails.background_test = {
          "stem": testMarksDetails.stem,
          "commerce & management": testMarksDetails.commerce_management,
          "creative & argumentative studies":
              testMarksDetails.creative_argumentative_studies,
          "civil services": testMarksDetails.civil_services,
          "defense": testMarksDetails.defense,
          "vocational courses": testMarksDetails.vocational_courses,
          "jobs as soon as possible": testMarksDetails.jobs_as_soon_as_possible,
        };
      }
      testMarksDetails.stem = 0.0;
      testMarksDetails.commerce_management = 0.0;
      testMarksDetails.creative_argumentative_studies = 0.0;
      testMarksDetails.civil_services = 0.0;
      testMarksDetails.defense = 0.0;
      testMarksDetails.vocational_courses = 0.0;
      testMarksDetails.jobs_as_soon_as_possible = 0.0;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: COLOR_THEME["primary"],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                ),
              ),
              onPressed: () async {
                // await login();
              },
              child: Text(
                "PREVIOUS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cabin',
                  fontSize: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: COLOR_THEME["primary"],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                ),
              ),
              onPressed: () async {
                print(personalityTestQuestions[currentIndex]["value"]
                        [answerEditor.text]
                    .runtimeType);
                if (personalityTestQuestions[currentIndex]["value"]
                            [answerEditor.text]
                        .runtimeType !=
                    List<dynamic>) {
                  print(
                      "${personalityTestQuestions[currentIndex]["question"]} ${answerEditor.text}");
                  increaseMarks(
                      personalityTestQuestions[currentIndex]["weightage"],
                      TestEnum.values[personalityTestQuestions[currentIndex]
                          ["value"][answerEditor.text]]);
                } else {
                  personalityTestQuestions[currentIndex]["value"]
                          [answerEditor.text]
                      .forEach((value) {
                    print("value : $value");
                    increaseMarks(
                        personalityTestQuestions[currentIndex]["weightage"],
                        TestEnum.values[value]);
                  });
                }
                if (currentIndex < totalLength - 1) {
                  setState(() {
                    answerEditor.text = "";
                    currentIndex++;
                  });
                } else {
                  print(testMarksDetails.stem);
                  print(testMarksDetails.commerce_management);
                  print(testMarksDetails.civil_services);
                  print(testMarksDetails.creative_argumentative_studies);
                  print(testMarksDetails.jobs_as_soon_as_possible);
                  String nextTest = nextTestName();
                  if (nextTest != "Result") {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        opaque: false,
                        transitionDuration: const Duration(milliseconds: 750),
                        pageBuilder: (_, __, ___) => TestDialogBox(
                          title: "Do you want to continue to $nextTest?",
                          testName: nextTest,
                        ),
                      ),
                    );
                  } else {}
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Text(
                  "NEXT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: screenHeight,
              width: screenWidth,
              child: const BigOneSmallOneBG(),
            ),
            Positioned(
              top: 0,
              width: screenWidth,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.testName.toUpperCase(),
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff32324D),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.05),
                        child: Image.asset(
                          "assets/images/aptitudeTestImage.png",
                          width: screenWidth * 0.8,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: (personalityTestQuestions.isNotEmpty)
                            ? Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenWidth * 0.15),
                                    child: ReasoningCard(
                                      options:
                                          personalityTestQuestions[currentIndex]
                                              ["options"],
                                      question:
                                          personalityTestQuestions[currentIndex]
                                              ["question"],
                                      title: widget.testName,
                                      answerEditor: answerEditor,
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
