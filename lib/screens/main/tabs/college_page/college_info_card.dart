import 'package:flutter/material.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/colleges_model.dart';
import 'package:nakshekadam/models/upcoming_exams_model.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/upcoming_exams_button/components.dart/upcoming_exams_card_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CollegeInfoCard extends StatelessWidget {
  const CollegeInfoCard({
    Key? key,
    required this.collegeModel,
    required this.index,
  }) : super(key: key);
  final CollegeModel collegeModel;
  final int index;

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
    return Card(
      color: (index % 2 == 0) ? COLOR_THEME["backgroundComponents2"] : COLOR_THEME["backgroundComponents0"],
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                collegeModel.level,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                collegeModel.institute,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
              child: Wrap(
                children: [
                  Text(
                    "Discipline  : ",
                    style: TextStyle(
                      color: COLOR_THEME["descriptionText"],
                      fontFamily: "Cabin",
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    collegeModel.discipline,
                    softWrap: true,
                    style: TextStyle(
                      color: COLOR_THEME["descriptionText"],
                      fontFamily: "Cabin",
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                Text(
                  "Faculty       : ",
                  softWrap: true,
                  style: TextStyle(
                    color: COLOR_THEME["descriptionText"],
                    fontFamily: "Cabin",
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  collegeModel.faculty,
                  softWrap: true,
                  style: TextStyle(
                    color: COLOR_THEME["descriptionText"],
                    fontFamily: "Cabin",
                    fontSize: screenWidth * 0.05,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
              child: Text(
                "Department : ${collegeModel.department}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
            Divider(
              color: COLOR_THEME["descriptionText"],
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
              child: Text(
                "Intake : ${collegeModel.intake}",
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
