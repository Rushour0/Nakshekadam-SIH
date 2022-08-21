import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/components/student_test_card.dart';
import 'package:nakshekadam/strings.dart';

class StudentTestsPage extends StatelessWidget {
  const StudentTestsPage({Key? key}) : super(key: key);

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

    List<String> testNames = [
      'Aptitude',
      'Interests',
      'Academic Background',
      'Personality & History',
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.03, top: screenHeight * 0.02),
                    child: Text(
                      "TESTS",
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: screenHeight * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.03, bottom: screenHeight * 0.01),
                    child: Text(
                      stringData["tests"]["summary"],
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: screenHeight * 0.02,
                        fontWeight: FontWeight.w600,
                        color: COLOR_THEME["descriptionText"],
                      ),
                    ),
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    mainAxisSpacing: screenWidth * 0.02,
                    // crossAxisSpacing: screenWidth * 0.04,
                    crossAxisSpacing: screenWidth * 0.02,
                    childAspectRatio: 0.9,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: testNames
                        .map(
                          (testName) => studentTestCard(screenHeight, screenWidth,
                              testName, testNames.indexOf(testName)),
                        )
                        .toList(),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.015,
                        bottom: screenHeight * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
