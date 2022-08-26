import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/cumulative_marks.dart';
import 'package:nakshekadam/models/test_marks_model.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/bottom_sheet.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_option_bottom_sheet.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/circular_chart.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/scholarshipExpansionTile.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/testExpansionTiles.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:http/http.dart' as http;

class DisplayTestResult extends StatefulWidget {
  const DisplayTestResult({
    Key? key,
  }) : super(key: key);

  @override
  State<DisplayTestResult> createState() => _DisplayTestResultState();
}

class _DisplayTestResultState extends State<DisplayTestResult> {
  UserDetailsModelOne userDetailsModelOne = UserDetailsModelOne.getModel();
  TestMarksDetails testMarksDetails = TestMarksDetails.getModel();
  CumulativeMarks cumulativeMarks = CumulativeMarks.getModel();
  Map<String, int> isTestGivenMap = {
    "Aptitude Test": 0,
    "Personality Test": 0,
    "Background Test": 0,
    "Interest Test": 0,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMarks();
  }

  void fetchMarks() async {
    DocumentSnapshot<Map<String, dynamic>> value =
        await userDocumentReference().get();
    UserDetailsModelOne.fromMap(value.data()!);
    // print("usermodel : $userDetailsModelOne");
    userDetailsModelOne.testGiven.asMap().forEach((key, value) {
      isTestGivenMap[isTestGivenMap.keys.elementAt(key)] = value;
    });
    int totalTests = 0;
    if (isTestGivenMap["Aptitude Test"] == 1) {
      totalTests++;
      testList.addAll({"Aptitude": false});
      DocumentSnapshot<Map<String, dynamic>> value =
          await userDocumentReference()
              .collection("data")
              .doc("aptitude_test")
              .get();
      testMarksDetails.aptitude_test = Map<String, double>.from(value.data()!);
    }
    if (isTestGivenMap["Background Test"] == 1) {
      totalTests++;
      testList.addAll({"Background": false});
      DocumentSnapshot<Map<String, dynamic>> value =
          await userDocumentReference()
              .collection("data")
              .doc("background_test")
              .get();
      testMarksDetails.background_test =
          Map<String, double>.from(value.data()!);
    }
    if (isTestGivenMap["Personality Test"] == 1) {
      totalTests++;
      testList.addAll({"Personality": false});
      DocumentSnapshot<Map<String, dynamic>> value =
          await userDocumentReference()
              .collection("data")
              .doc("personality_marks")
              .get();
      testMarksDetails.personality_marks =
          Map<String, double>.from(value.data()!);
    }
    if (isTestGivenMap["Interest Test"] == 1) {
      totalTests++;
      testList.addAll({"Interest": false});
      DocumentSnapshot<Map<String, dynamic>> value =
          await userDocumentReference()
              .collection("data")
              .doc("interest_test")
              .get();
      testMarksDetails.interest_test = Map<String, double>.from(value.data()!);
    }
    print(userDetailsModelOne.testGiven);
    print(totalTests);

    cumulativeMarks.stem = (testMarksDetails.aptitude_test["stem"]! +
            testMarksDetails.background_test["stem"]! +
            testMarksDetails.interest_test["stem"]! +
            testMarksDetails.personality_marks["stem"]!) /
        totalTests;

    cumulativeMarks.commerce_management =
        (testMarksDetails.aptitude_test["commerce & management"]! +
                testMarksDetails.background_test["commerce & management"]! +
                testMarksDetails.interest_test["commerce & management"]! +
                testMarksDetails.personality_marks["commerce & management"]!) /
            totalTests;

    cumulativeMarks.creative_argumentative_studies =
        (testMarksDetails.aptitude_test["creative & argumentative studies"]! +
                testMarksDetails
                    .background_test["creative & argumentative studies"]! +
                testMarksDetails
                    .interest_test["creative & argumentative studies"]! +
                testMarksDetails
                    .personality_marks["creative & argumentative studies"]!) /
            totalTests;

    cumulativeMarks.civil_services =
        (testMarksDetails.aptitude_test["civil services"]! +
                testMarksDetails.background_test["civil services"]! +
                testMarksDetails.interest_test["civil services"]! +
                testMarksDetails.personality_marks["civil services"]!) /
            totalTests;

    cumulativeMarks.defense = (testMarksDetails.aptitude_test["defense"]! +
            testMarksDetails.background_test["defense"]! +
            testMarksDetails.interest_test["defense"]! +
            testMarksDetails.personality_marks["defense"]!) /
        totalTests;

    cumulativeMarks.vocational_courses =
        (testMarksDetails.aptitude_test["vocational courses"]! +
                testMarksDetails.background_test["vocational courses"]! +
                testMarksDetails.interest_test["vocational courses"]! +
                testMarksDetails.personality_marks["vocational courses"]!) /
            totalTests;

    cumulativeMarks.jobs_as_soon_as_possible = (testMarksDetails
                .aptitude_test["jobs as soon as possible"]! +
            testMarksDetails.background_test["jobs as soon as possible"]! +
            testMarksDetails.interest_test["jobs as soon as possible"]! +
            testMarksDetails.personality_marks["jobs as soon as possible"]!) /
        totalTests;

    setState(() {});
  }

  Map<String, bool> testList = {};

  Map<String, double> higestScore() {
    if (cumulativeMarks.stem >= cumulativeMarks.commerce_management &&
        cumulativeMarks.stem >=
            cumulativeMarks.creative_argumentative_studies &&
        cumulativeMarks.stem >= cumulativeMarks.civil_services &&
        cumulativeMarks.stem >= cumulativeMarks.defense &&
        cumulativeMarks.stem >= cumulativeMarks.vocational_courses &&
        cumulativeMarks.stem >= cumulativeMarks.jobs_as_soon_as_possible) {
      return {"STEM": cumulativeMarks.stem};
    } else if (cumulativeMarks.commerce_management >= cumulativeMarks.stem &&
        cumulativeMarks.commerce_management >=
            cumulativeMarks.creative_argumentative_studies &&
        cumulativeMarks.commerce_management >= cumulativeMarks.civil_services &&
        cumulativeMarks.commerce_management >= cumulativeMarks.defense &&
        cumulativeMarks.commerce_management >=
            cumulativeMarks.vocational_courses &&
        cumulativeMarks.commerce_management >=
            cumulativeMarks.jobs_as_soon_as_possible) {
      return {"Commerce & Management": cumulativeMarks.commerce_management};
    } else if (cumulativeMarks.creative_argumentative_studies >=
            cumulativeMarks.stem &&
        cumulativeMarks.creative_argumentative_studies >=
            cumulativeMarks.commerce_management &&
        cumulativeMarks.creative_argumentative_studies >=
            cumulativeMarks.civil_services &&
        cumulativeMarks.creative_argumentative_studies >=
            cumulativeMarks.defense &&
        cumulativeMarks.creative_argumentative_studies >=
            cumulativeMarks.vocational_courses &&
        cumulativeMarks.creative_argumentative_studies >=
            cumulativeMarks.jobs_as_soon_as_possible) {
      return {
        "Creative & Argumentative Studies":
            cumulativeMarks.creative_argumentative_studies
      };
    } else if (cumulativeMarks.civil_services >= cumulativeMarks.stem &&
        cumulativeMarks.civil_services >= cumulativeMarks.commerce_management &&
        cumulativeMarks.civil_services >=
            cumulativeMarks.creative_argumentative_studies &&
        cumulativeMarks.civil_services >= cumulativeMarks.defense &&
        cumulativeMarks.civil_services >= cumulativeMarks.vocational_courses &&
        cumulativeMarks.civil_services >=
            cumulativeMarks.jobs_as_soon_as_possible) {
      return {"Civil Services": cumulativeMarks.civil_services};
    } else if (cumulativeMarks.defense >= cumulativeMarks.stem &&
        cumulativeMarks.defense >= cumulativeMarks.commerce_management &&
        cumulativeMarks.defense >=
            cumulativeMarks.creative_argumentative_studies &&
        cumulativeMarks.defense >= cumulativeMarks.civil_services &&
        cumulativeMarks.defense >= cumulativeMarks.vocational_courses &&
        cumulativeMarks.defense >= cumulativeMarks.jobs_as_soon_as_possible) {
      return {"Defense": cumulativeMarks.defense};
    } else if (cumulativeMarks.vocational_courses >= cumulativeMarks.stem &&
        cumulativeMarks.vocational_courses >=
            cumulativeMarks.commerce_management &&
        cumulativeMarks.vocational_courses >=
            cumulativeMarks.creative_argumentative_studies &&
        cumulativeMarks.vocational_courses >= cumulativeMarks.civil_services &&
        cumulativeMarks.vocational_courses >= cumulativeMarks.defense &&
        cumulativeMarks.vocational_courses >=
            cumulativeMarks.jobs_as_soon_as_possible) {
      return {"Vocational Courses": cumulativeMarks.vocational_courses};
    } else {
      return {
        "Jobs as Soon as Possible": cumulativeMarks.jobs_as_soon_as_possible
      };
    }
  }

  void clearCumulation() {
    cumulativeMarks.stem = 0;
    cumulativeMarks.commerce_management = 0;
    cumulativeMarks.creative_argumentative_studies = 0;
    cumulativeMarks.civil_services = 0;
    cumulativeMarks.defense = 0;
    cumulativeMarks.vocational_courses = 0;
    cumulativeMarks.jobs_as_soon_as_possible = 0;
  }

  void addMarksInCumulation(String testname) {
    if (testname == "Aptitude") {
      cumulativeMarks.stem += (testMarksDetails.aptitude_test["stem"]!);

      cumulativeMarks.commerce_management +=
          (testMarksDetails.aptitude_test["commerce & management"]!);

      cumulativeMarks.creative_argumentative_studies +=
          (testMarksDetails.aptitude_test["creative & argumentative studies"]!);

      cumulativeMarks.civil_services +=
          (testMarksDetails.aptitude_test["civil services"]!);

      cumulativeMarks.defense += (testMarksDetails.aptitude_test["defense"]!);

      cumulativeMarks.vocational_courses +=
          (testMarksDetails.aptitude_test["vocational courses"]!);

      cumulativeMarks.jobs_as_soon_as_possible +=
          (testMarksDetails.aptitude_test["jobs as soon as possible"]!);
    } else if (testname == "Background") {
      cumulativeMarks.stem += (testMarksDetails.background_test["stem"]!);

      cumulativeMarks.commerce_management +=
          (testMarksDetails.background_test["commerce & management"]!);

      cumulativeMarks.creative_argumentative_studies += (testMarksDetails
          .background_test["creative & argumentative studies"]!);

      cumulativeMarks.civil_services +=
          (testMarksDetails.background_test["civil services"]!);

      cumulativeMarks.defense += (testMarksDetails.background_test["defense"]!);

      cumulativeMarks.vocational_courses +=
          (testMarksDetails.background_test["vocational courses"]!);

      cumulativeMarks.jobs_as_soon_as_possible +=
          (testMarksDetails.background_test["jobs as soon as possible"]!);
    } else if (testname == "Personality") {
      cumulativeMarks.stem += (testMarksDetails.personality_marks["stem"]!);

      cumulativeMarks.commerce_management +=
          (testMarksDetails.personality_marks["commerce & management"]!);

      cumulativeMarks.creative_argumentative_studies += (testMarksDetails
          .personality_marks["creative & argumentative studies"]!);

      cumulativeMarks.civil_services +=
          (testMarksDetails.personality_marks["civil services"]!);

      cumulativeMarks.defense +=
          (testMarksDetails.personality_marks["defense"]!);

      cumulativeMarks.vocational_courses +=
          (testMarksDetails.personality_marks["vocational courses"]!);

      cumulativeMarks.jobs_as_soon_as_possible +=
          (testMarksDetails.personality_marks["jobs as soon as possible"]!);
    } else if (testname == "Interest") {
      cumulativeMarks.stem += (testMarksDetails.interest_test["stem"]!);

      cumulativeMarks.commerce_management +=
          (testMarksDetails.interest_test["commerce & management"]!);

      cumulativeMarks.creative_argumentative_studies +=
          (testMarksDetails.interest_test["creative & argumentative studies"]!);

      cumulativeMarks.civil_services +=
          (testMarksDetails.interest_test["civil services"]!);

      cumulativeMarks.defense += (testMarksDetails.interest_test["defense"]!);

      cumulativeMarks.vocational_courses +=
          (testMarksDetails.interest_test["vocational courses"]!);

      cumulativeMarks.jobs_as_soon_as_possible +=
          (testMarksDetails.interest_test["jobs as soon as possible"]!);
    }
    print(cumulativeMarks.commerce_management);
  }

  void averageCumulativeMarks(int totalCumulativeIndex) {
    cumulativeMarks.stem = cumulativeMarks.stem / totalCumulativeIndex;
    cumulativeMarks.commerce_management =
        cumulativeMarks.commerce_management / totalCumulativeIndex;
    cumulativeMarks.creative_argumentative_studies =
        cumulativeMarks.creative_argumentative_studies / totalCumulativeIndex;
    cumulativeMarks.civil_services =
        cumulativeMarks.civil_services / totalCumulativeIndex;
    cumulativeMarks.defense = cumulativeMarks.defense / totalCumulativeIndex;
    cumulativeMarks.vocational_courses =
        cumulativeMarks.vocational_courses / totalCumulativeIndex;
    cumulativeMarks.jobs_as_soon_as_possible =
        cumulativeMarks.jobs_as_soon_as_possible / totalCumulativeIndex;
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

    Map<String, double> higestScoreNameValue = higestScore();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                var url = Uri.parse(
                                    "https://nakshekadam.tushar725mittal.repl.co/colleges");

                                final response = await http.get(url);
                                print("response : $response");
                                if (response.statusCode == 200) {}
                              },
                              child: Card(
                                color: COLOR_THEME["secondary"],
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04,
                                      vertical: screenHeight * 0.01),
                                  child: Text(
                                    "DOWNLOAD FULL REPORT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: screenWidth * 0.15),
                              child: Column(
                                children: [
                                  Text(
                                    "TEST RESULTS",
                                    style: TextStyle(
                                      fontFamily: "DM Sans",
                                      fontSize: screenWidth * 0.08,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  (userDetailsModelOne.under_3L)
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.02),
                                          child: Text(
                                            "We feel thrilled that you chose to share your grievances with us. Considering you mentioned your family's annual income on the lower side, we would like to recommend you a few scholarships and free study resources customized for you.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Cabin',
                                              fontSize: screenWidth * 0.05,
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.05),
                                    child: Image.asset(
                                      "assets/images/displayTestResult.png",
                                      width: screenWidth * 0.8,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Text(
                                    "View all your test results to understand what our model thinks is the best for you. You can customize which combination of parameters account for your cumulative. Choose 1,2, 3 or all 4 options to view a dynamic overview of your capability in all domains rated on a scale of 100!",
                                    style: TextStyle(
                                      fontFamily: "DM Sans",
                                      fontSize: screenWidth * 0.04,
                                      color: COLOR_THEME["descriptionText"],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.03),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: ExpansionTile(
                                        collapsedBackgroundColor:
                                            COLOR_THEME["careerTile"],
                                        backgroundColor:
                                            COLOR_THEME["careerTileExpanded"],
                                        title: Text(
                                          "Customise your report",
                                          style: TextStyle(
                                            fontFamily: "DM Sans",
                                            fontSize: screenWidth * 0.04,
                                            color: const Color(0xff32324D),
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff32324D),
                                        ),
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.9,
                                            child: Card(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenWidth * 0.05),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth * 0.05),
                                              ),
                                              elevation: 0,
                                              color: COLOR_THEME[
                                                  "careerTileExpanded"],
                                              child: SizedBox(
                                                // height: screenHeight * 0.75,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * 0.015,
                                                    horizontal:
                                                        screenWidth * 0.03,
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "DOMAIN",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "DM Sans",
                                                              fontSize:
                                                                  screenWidth *
                                                                      0.05,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const Divider(
                                                          color: Colors.grey,
                                                          thickness: 1,
                                                        ),
                                                        ...testList.keys.map(
                                                          (test) => Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Checkbox(
                                                                fillColor:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  COLOR_THEME[
                                                                      "descriptionText"],
                                                                ),
                                                                value: testList[
                                                                    test],
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    testList[
                                                                            test] =
                                                                        value!;
                                                                  });
                                                                },
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                        0.5,
                                                                child: Text(
                                                                  test,
                                                                  softWrap:
                                                                      true,
                                                                  style:
                                                                      TextStyle(
                                                                    color: COLOR_THEME[
                                                                        "descriptionText"],
                                                                    fontFamily:
                                                                        "DM Sans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        screenWidth *
                                                                            0.05,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  clearCumulation();
                                                                  int totalCumulativeIndex =
                                                                      0;
                                                                  testList.forEach(
                                                                      (key,
                                                                          value) {
                                                                    if (value) {
                                                                      totalCumulativeIndex++;
                                                                      addMarksInCumulation(
                                                                          key);
                                                                    }
                                                                  });
                                                                  if (totalCumulativeIndex ==
                                                                      0) {
                                                                    testList.forEach(
                                                                        (key,
                                                                            value) {
                                                                      totalCumulativeIndex++;
                                                                      addMarksInCumulation(
                                                                          key);
                                                                    });
                                                                    averageCumulativeMarks(
                                                                        totalCumulativeIndex);
                                                                    setState(
                                                                        () {
                                                                      higestScoreNameValue =
                                                                          higestScore();
                                                                    });
                                                                  } else {
                                                                    averageCumulativeMarks(
                                                                        totalCumulativeIndex);
                                                                    setState(
                                                                        () {
                                                                      higestScoreNameValue =
                                                                          higestScore();
                                                                    });
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "Sort",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "DM Sans",
                                                                    fontSize:
                                                                        screenWidth *
                                                                            0.05,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  clearCumulation();
                                                                  testList.forEach(
                                                                      (key,
                                                                          value) {
                                                                    if (value) {
                                                                      testList[
                                                                              key] =
                                                                          false;
                                                                      setState(
                                                                          () {
                                                                        higestScoreNameValue =
                                                                            higestScore();
                                                                      });
                                                                    }
                                                                  });
                                                                  int totalCumulativeIndex =
                                                                      0;
                                                                  testList.forEach(
                                                                      (key,
                                                                          value) {
                                                                    totalCumulativeIndex++;
                                                                    addMarksInCumulation(
                                                                        key);
                                                                  });
                                                                  averageCumulativeMarks(
                                                                      totalCumulativeIndex);
                                                                  setState(() {
                                                                    higestScoreNameValue =
                                                                        higestScore();
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "Clear all",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontFamily:
                                                                        "DM Sans",
                                                                    fontSize:
                                                                        screenWidth *
                                                                            0.05,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.03),
                                    child: Text(
                                      "TOP STREAM",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "DM Sans",
                                        fontSize: screenWidth * 0.07,
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/topStreamImage.png",
                                    width: screenWidth * 0.5,
                                    height: screenWidth * 0.5,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await showModalBottomSheet(
                                          constraints: BoxConstraints(
                                            maxHeight: screenHeight * 0.95,
                                          ),
                                          isScrollControlled: true,
                                          isDismissible: false,
                                          // enableDrag: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              screenWidth,
                                            ),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) {
                                            return CareerOptionBottomSheet(
                                                title: higestScoreNameValue.keys
                                                    .elementAt(0),
                                                optionCardName:
                                                    "post_login_career_options");
                                          });
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.03),
                                      ),
                                      color: COLOR_THEME["secondary"],
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.01,
                                            horizontal: screenWidth * 0.05),
                                        child: Text(
                                          higestScoreNameValue.keys
                                              .elementAt(0),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "DM Sans",
                                            fontSize: screenWidth * 0.06,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await showModalBottomSheet(
                                          constraints: BoxConstraints(
                                            maxHeight: screenHeight * 0.95,
                                          ),
                                          isScrollControlled: true,
                                          isDismissible: false,
                                          // enableDrag: false,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              screenWidth,
                                            ),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (builder) {
                                            return CustomBottomSheet(
                                              routeName:
                                                  "post_login_career_options",
                                            );
                                          });
                                    },
                                    child: Text(
                                      "Read about all other streams",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic,
                                        color: COLOR_THEME["secondary"],
                                        fontFamily: "DM Sans",
                                        fontSize: screenWidth * 0.04,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.03),
                                    child: Text(
                                      "DETAILED ANALYSIS",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "DM Sans",
                                        fontSize: screenWidth * 0.07,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: CircularChart(
                                      domain: higestScoreNameValue.keys
                                          .elementAt(0),
                                      percentage: double.parse(
                                        higestScoreNameValue.values
                                            .elementAt(0)
                                            .toStringAsFixed(2),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: testList.keys.map(
                                      (key) {
                                        Map<String, double> tempMarksMap = {};
                                        if (key == "Aptitude") {
                                          tempMarksMap =
                                              testMarksDetails.aptitude_test;
                                        } else if (key == "Background") {
                                          tempMarksMap =
                                              testMarksDetails.background_test;
                                        } else if (key == "Personality") {
                                          tempMarksMap = testMarksDetails
                                              .personality_marks;
                                        } else if (key == "Interest") {
                                          tempMarksMap =
                                              testMarksDetails.interest_test;
                                        }
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.02),
                                          child: TestExpansionTile(
                                            testName: key,
                                            marksMap: tempMarksMap,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02,
                                        bottom: screenHeight * 0.02),
                                    child: TestExpansionTile(
                                      testName: "Cumulative Analysis",
                                      marksMap: {
                                        "stem": cumulativeMarks.stem,
                                        "commerce & management":
                                            cumulativeMarks.commerce_management,
                                        "creative & argumentative studies":
                                            cumulativeMarks
                                                .creative_argumentative_studies,
                                        "civil services":
                                            cumulativeMarks.civil_services,
                                        "defense": cumulativeMarks.defense,
                                        "vocational courses":
                                            cumulativeMarks.vocational_courses,
                                        "jobs as soon as possible":
                                            cumulativeMarks
                                                .jobs_as_soon_as_possible,
                                      },
                                    ),
                                  ),
                                  (userDetailsModelOne.under_3L)
                                      ? ScholarshipExpansionTile()
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
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
