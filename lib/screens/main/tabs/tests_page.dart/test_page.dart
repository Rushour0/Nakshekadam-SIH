import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/signup_dialog.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_card.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_card_dialog.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_buttons.dart';
import 'package:nakshekadam/screens/main/tabs/resources_page/components/resource_card.dart';
import 'package:nakshekadam/screens/main/tabs/tests_page.dart/components/test_button.dart';
import 'package:nakshekadam/screens/main/tabs/tests_page.dart/components/tests_card.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({Key? key}) : super(key: key);

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
      'Interest',
      'Background',
      'Personality',
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
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: testNames
                        .map(
                          (testName) => testCard(screenHeight, screenWidth,
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
                      child: GestureDetector(
                          onTap: () async {
                            if (await checkLoggedIn()) {
                            } else {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  barrierDismissible: true,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  opaque: false,
                                  transitionDuration:
                                      const Duration(milliseconds: 750),
                                  pageBuilder: (_, __, ___) => SignupDialogBox(
                                    title:
                                        "Unlock access to all tests by signing up for our customizable and accurate results! For tests and much more",
                                  ),
                                ),
                              );
                            }
                          },
                          child: testButton(
                              screenHeight, screenWidth, "TAKE TEST NOW!")),
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
