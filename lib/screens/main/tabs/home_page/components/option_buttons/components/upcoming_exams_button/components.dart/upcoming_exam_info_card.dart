import 'package:flutter/material.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/upcoming_exams_model.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/upcoming_exams_button/components.dart/upcoming_exams_card_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UpcomingExamInfoCard extends StatelessWidget {
  const UpcomingExamInfoCard({
    Key? key,
    required this.upcomingExam,
    required this.index,
  }) : super(key: key);
  final UpcomingExam upcomingExam;
  final int index;

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController;
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
      color: (index % 2 == 0)
          ? COLOR_THEME["backgroundComponents2"]
          : COLOR_THEME["backgroundComponents0"],
      elevation: 2,
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
                "${upcomingExam.notifyDate.day}/${upcomingExam.notifyDate.month}/${upcomingExam.notifyDate.year}",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ),
            Text(
              upcomingExam.examName,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Cabin",
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
              child: Text(
                "Domain : ${upcomingExam.examDomain}",
                style: TextStyle(
                  color: COLOR_THEME["descriptionText"],
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
            Text(
              "Date of Exam: ${upcomingExam.examDate.day}/${upcomingExam.examDate.month}/${upcomingExam.examDate.year}",
              softWrap: true,
              style: TextStyle(
                color: COLOR_THEME["descriptionText"],
                fontFamily: "Cabin",
                fontSize: screenWidth * 0.05,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.007),
              child: Text(
                upcomingExam.examDescription,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Container(
                        height: screenHeight * 0.5,
                        width: screenWidth * 0.9,
                        child: WebView(
                          initialUrl: upcomingExam.link,
                          zoomEnabled: false,
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageStarted: (url) async {},
                          onWebViewCreated: (controller) {
                            webViewController = controller;
                          },
                        ),
                      );
                    }),
                  );
                },
                child: upcomingExamsCardButton(screenHeight, screenWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
