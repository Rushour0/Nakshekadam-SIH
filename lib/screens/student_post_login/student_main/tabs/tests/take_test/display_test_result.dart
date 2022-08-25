import 'package:flutter/material.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/circular_chart.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/testExpansionTiles.dart';

class DisplayTestResult extends StatefulWidget {
  const DisplayTestResult({
    Key? key,
  }) : super(key: key);

  @override
  State<DisplayTestResult> createState() => _DisplayTestResultState();
}

class _DisplayTestResultState extends State<DisplayTestResult> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Map<String, bool> testList = {
    "Aptitude": false,
    "Interests": false,
    "Academic": false,
    "Personality": false
  };

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
                          "TEST RESULTS",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                                    "View all your test results  to understand what our model thinks is the best for you. You can customize which combination of parameters account for your cumulative. Choose 1,2, 3 or all 4 options to view a dynamic overview of your capability in all domains rated on a scale of 100!",
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
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              testList.forEach(
                                                                  (key, value) {
                                                                if (value) {
                                                                  testList[
                                                                          key] =
                                                                      false;
                                                                  setState(
                                                                      () {});
                                                                }
                                                              });
                                                            },
                                                            child: Text(
                                                              "Clear all",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontFamily:
                                                                    "DM Sans",
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.05,
                                                              ),
                                                            ),
                                                          ),
                                                        )
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
                                  Card(
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
                                        "STEM",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "DM Sans",
                                          fontSize: screenWidth * 0.06,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Read about all other streams",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                      color: COLOR_THEME["secondary"],
                                      fontFamily: "DM Sans",
                                      fontSize: screenWidth * 0.04,
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
                                      domain: "STEM",
                                      percentage: 0.89,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: TestExpansionTile(
                                      testName: "APTITUDE",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: TestExpansionTile(
                                      testName: "INTERESTS",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: TestExpansionTile(
                                      testName: "ACADEMIC BACKGROUND",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: TestExpansionTile(
                                      testName: "PERSONALITY & HISTORY",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: TestExpansionTile(
                                      testName: "CUMULATIVE ANALYSIS",
                                    ),
                                  ),
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
