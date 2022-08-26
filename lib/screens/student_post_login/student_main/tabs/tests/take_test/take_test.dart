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
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/components/test_done_dialogbox.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/test_card.dart';
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

    Future<String> nextTestName(String current_testName) async {
      var futureForTestGiven = await userDocumentReference().get();
      List fetchedTestGiven =
          (futureForTestGiven.data() as Map<String, dynamic>)["testGiven"];
      print(current_testName);
      if (current_testName == "Reasoning") {
        return "Numerical Ability";
      } else if (current_testName == "Numerical Ability") {
        if (fetchedTestGiven[1] == 1) {
          return nextTestName("Personality Test");
        }
        return "Personality Test";
      } else if (current_testName == "Personality Test") {
        if (fetchedTestGiven[2] == 1) {
          return nextTestName("Background Test");
        }
        return "Background Test";
      } else if (current_testName == "Background Test") {
        if (fetchedTestGiven[3] == 1) {
          return nextTestName("Interest Test");
        }
        return "Interest Test";
      }
      print("hello");

      return "Result";
    }

    Future<void> saveResultAndEmptyModel() async {
      if (widget.testName == "Reasoning") {
        testMarksDetails.aptitude_test = {
          "stem": testMarksDetails.stem,
          "commerce & management": testMarksDetails.commerce_management,
          "creative & argumentative studies":
              testMarksDetails.creative_argumentative_studies,
          "civil services": testMarksDetails.civil_services,
          "defense": testMarksDetails.defense,
          "vocational courses": testMarksDetails.vocational_courses,
          "jobs as soon as possible": testMarksDetails.jobs_as_soon_as_possible,
        };
        await userDocumentReference()
            .collection("data")
            .doc("aptitude_test")
            .set(testMarksDetails.aptitude_test);
        var futureForTestGiven = await userDocumentReference().get();
        List fetchedTestGiven =
            (futureForTestGiven.data() as Map<String, dynamic>)["testGiven"];
        fetchedTestGiven[0] = 1;
        await userDocumentReference().update({"testGiven": fetchedTestGiven});
      } else if (widget.testName == "Numerical Ability") {
        double stem = testMarksDetails.aptitude_test["stem"]!;
        double cm = testMarksDetails.aptitude_test["commerce & management"]!;
        double cas =
            testMarksDetails.aptitude_test["creative & argumentative studies"]!;
        double cs = testMarksDetails.aptitude_test["civil services"]!;
        double d = testMarksDetails.aptitude_test["defense"]!;
        double vc = testMarksDetails.aptitude_test["vocational courses"]!;
        double jasap =
            testMarksDetails.aptitude_test["jobs as soon as possible"]!;
        testMarksDetails.aptitude_test = {
          "stem": testMarksDetails.stem + stem,
          "commerce & management": testMarksDetails.commerce_management + cm,
          "creative & argumentative studies":
              testMarksDetails.creative_argumentative_studies + cas,
          "civil services": testMarksDetails.civil_services + cs,
          "defense": testMarksDetails.defense + d,
          "vocational courses": testMarksDetails.vocational_courses + vc,
          "jobs as soon as possible":
              testMarksDetails.jobs_as_soon_as_possible + jasap,
        };
        await userDocumentReference()
            .collection("data")
            .doc("aptitude_test")
            .set(testMarksDetails.aptitude_test);
        var futureForTestGiven = await userDocumentReference().get();
        List fetchedTestGiven =
            (futureForTestGiven.data() as Map<String, dynamic>)["testGiven"];
        fetchedTestGiven[0] = 1;
        await userDocumentReference().update({"testGiven": fetchedTestGiven});
      } else if (widget.testName == "Personality Test") {
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
        await userDocumentReference()
            .collection("data")
            .doc("personality_marks")
            .set(testMarksDetails.personality_marks);
        var futureForTestGiven = await userDocumentReference().get();
        List fetchedTestGiven =
            (futureForTestGiven.data() as Map<String, dynamic>)["testGiven"];
        fetchedTestGiven[1] = 1;
        await userDocumentReference().update({"testGiven": fetchedTestGiven});
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
        await userDocumentReference()
            .collection("data")
            .doc("background_test")
            .set(testMarksDetails.background_test);
        var futureForTestGiven = await userDocumentReference().get();
        List fetchedTestGiven =
            (futureForTestGiven.data() as Map<String, dynamic>)["testGiven"];
        fetchedTestGiven[2] = 1;
        await userDocumentReference().update({"testGiven": fetchedTestGiven});
      } else if (widget.testName == "Interest Test") {
        testMarksDetails.interest_test = {
          "stem": testMarksDetails.stem,
          "commerce & management": testMarksDetails.commerce_management,
          "creative & argumentative studies":
              testMarksDetails.creative_argumentative_studies,
          "civil services": testMarksDetails.civil_services,
          "defense": testMarksDetails.defense,
          "vocational courses": testMarksDetails.vocational_courses,
          "jobs as soon as possible": testMarksDetails.jobs_as_soon_as_possible,
        };
        await userDocumentReference()
            .collection("data")
            .doc("interest_test")
            .set(testMarksDetails.interest_test);
        var futureForTestGiven = await userDocumentReference().get();
        List fetchedTestGiven =
            (futureForTestGiven.data() as Map<String, dynamic>)["testGiven"];
        fetchedTestGiven[3] = 1;
        await userDocumentReference().update({"testGiven": fetchedTestGiven});
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
                if (answerEditor.text == "") {
                  return;
                }
                print("answer : ${answerEditor.text}");
                print(
                    "value : ${personalityTestQuestions[currentIndex]["value"][answerEditor.text]}");
                print(
                    "value runtimeType : ${personalityTestQuestions[currentIndex]["value"][answerEditor.text].runtimeType}");
                if (widget.testName == "Background Test" &&
                    personalityTestQuestions[currentIndex]["question"] ==
                        "Your parents' annual income is below 3L") {
                  print("question entered");
                  bool answer = false;
                  print(personalityTestQuestions[currentIndex]["options"]
                      [int.parse(answerEditor.text)]);
                  if (personalityTestQuestions[currentIndex]["options"]
                          [int.parse(answerEditor.text)] ==
                      "Yes") {
                    answer = true;
                  }
                  await userDocumentReference().update({"under_3L": answer});
                }
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
                  await saveResultAndEmptyModel();
                  String nextTest = await nextTestName(widget.testName);
                  print("next text : $nextTest");
                  if (nextTest == "Result") {
                    var futureForTestGiven =
                        await userDocumentReference().get();
                    List fetchedTestGiven = (futureForTestGiven.data()
                        as Map<String, dynamic>)["testGiven"];
                    if (fetchedTestGiven.contains(0)) {
                      if (fetchedTestGiven[0] == 0) {
                        nextTest = "Reasoning";
                      } else {
                        nextTest = await nextTestName("Numerical Ability");
                      }
                    } else {
                      Navigator.pushNamed(context, '/displayTestResult');
                    }
                  }
                  print("next text : $nextTest");
                  if (nextTest == "Numerical Ability") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TakeTest(testName: nextTest),
                      ),
                    );
                  } else if (nextTest != "Result") {
                    print("going to next test");
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
                          (widget.testName.toLowerCase() != "reasoning" ||
                                  widget.testName.toLowerCase() !=
                                      "numerical ability")
                              ? widget.testName.toUpperCase()
                              : "APTITUDE TEST",
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
                                  child: (widget.testName ==
                                              "Background Test" &&
                                          personalityTestQuestions[currentIndex]
                                                  ["question"] ==
                                              "Your parents' annual income is below 3L")
                                      ? Column(
                                          children: [
                                            Text(
                                              "We feel thrilled that you chose to share your grievances with us. Considering you mentioned your family's annual income on the lower side, we would like to recommend you a few scholarships and free study resources customized for you.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Cabin',
                                                fontSize: screenWidth * 0.05,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: screenWidth * 0.15),
                                              child: TestCard(
                                                options:
                                                    personalityTestQuestions[
                                                            currentIndex]
                                                        ["options"],
                                                question:
                                                    personalityTestQuestions[
                                                            currentIndex]
                                                        ["question"],
                                                title: widget.testName,
                                                answerEditor: answerEditor,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              bottom: screenWidth * 0.15),
                                          child: TestCard(
                                            options: personalityTestQuestions[
                                                currentIndex]["options"],
                                            question: personalityTestQuestions[
                                                currentIndex]["question"],
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
