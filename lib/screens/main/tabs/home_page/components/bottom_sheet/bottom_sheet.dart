import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/data_for_bottom_sheet.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/infographics.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/upcoming_exams_button/upcoming_exam_page.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_based_cards.dart';
import 'package:nakshekadam/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key, required this.routeName})
      : super(key: key);

  final String routeName;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final String routeName = widget.routeName;
    late WebViewController webViewController;
    String title = routeName
        .replaceAll('_', ' ')
        .replaceAll("post login ", "")
        .toUpperCase();
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
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              screenWidth / 20,
            ),
            topRight: Radius.circular(
              screenWidth / 20,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            commonBottomSheetTitle(
              title: title,
              screenWidth: screenWidth,
            ),
            (routeName == 'career_options' ||
                    routeName == 'post_login_career_options')
                ? Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowIndicator();
                        return false;
                      },
                      child: SingleChildScrollView(
                        child: Wrap(
                          // runAlignment: WrapAlignment.spaceEvenly,
                          alignment: WrapAlignment.center,
                          // crossAxisAlignment: W,
                          spacing: screenWidth * 0.0275,
                          runSpacing: screenWidth * 0.0275,
                          children: <Widget>[
                                infographicsAndText(
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  routeName: routeName,
                                ),
                              ] +
                              [
                                SizedBox(
                                  height: screenHeight * 0.01,
                                  width: screenWidth,
                                )
                              ] +
                              CAREER_OPTIONS_SUMMARY.keys
                                  .map(
                                    (career) => CareerOptionsCard(
                                      title: career,
                                      summary: CAREER_OPTIONS_SUMMARY[career],
                                      side: screenWidth * 0.45,
                                      routeName: routeName,
                                    ),
                                  )
                                  .toList() +
                              [
                                SizedBox(
                                  height: screenHeight * 0.02,
                                  width: screenWidth,
                                )
                              ],
                        ),
                      ),
                    ),
                  )
                : routeName == 'upcoming_exams'
                    ?
                    // Container()
                    Expanded(child: UpcomingExamsPage())
                    : Expanded(
                        child: WebView(
                          gestureRecognizers: Set()
                            ..add(
                              Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer(),
                              ), // or null
                            ),
                          initialUrl: routeName == 'scholarships'
                              ? "https://www.learncbse.in/scholarships-for-students/"
                              : "https://www.ncs.gov.in/content-repository/Pages/BrowseBySectors.aspx",
                          zoomEnabled: false,
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageFinished: (url) async {
                            if (routeName == 'industries') {
                              await webViewController.scrollTo(
                                  0, (screenHeight * 0.875).toInt());
                            }
                          },
                          onWebViewCreated: (controller) {
                            webViewController = controller;
                            webViewController.getScrollY().then((value) async {
                              if (value < screenHeight * 0.875) {
                                await webViewController.scrollTo(
                                    0, (screenHeight * 0.875).toInt());
                              }
                            });
                          },
                        ),
                      ),
          ],
        ));
  }
}

commonBottomSheetTitle({required title, required screenWidth}) {
  TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: "DM Sans",
    fontSize: screenWidth * 0.07,
    fontWeight: FontWeight.bold,
  );

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 2.75,
          vertical: screenWidth * 0.05,
        ),
        child: Container(
          width: screenWidth,
          height: screenWidth * 0.02,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(
              screenWidth / 30,
            ),
          ),
        ),
      ),
      Container(
        color: COLOR_THEME['primary'],
        width: screenWidth,
        height: screenWidth * 0.14,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
        ),
      ),
    ],
  );
}
