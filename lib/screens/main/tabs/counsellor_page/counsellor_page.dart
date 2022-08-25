import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_card.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_card_dialog.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_buttons.dart';
import 'package:nakshekadam/screens/main/tabs/resources_page/components/resource_card.dart';
import 'package:nakshekadam/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CounsellorPage extends StatelessWidget {
  const CounsellorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModelOne userDetailsModelOne = UserDetailsModelOne.getModel();
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

    List<String> counsellorTypes = [
      // 'Vidya Bot',
      'Industrial Experts',
      'Professional Counsellors'
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
              padding: EdgeInsets.only(
                  bottom: screenHeight * 0.1, top: screenHeight * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: Text(
                      "COUNSELLORS",
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
                    child: (userDetailsModelOne.role == "parent")
                        ? Text(
                            stringData["counsellors"]["parent"],
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.w600,
                              color: COLOR_THEME["descriptionText"],
                            ),
                          )
                        : Text(
                            stringData["counsellors"]["summary"],
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.w600,
                              color: COLOR_THEME["descriptionText"],
                            ),
                          ),
                  ),
                  Align(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: counsellorTypes.map((title) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.5),
                                opaque: false,
                                transitionDuration:
                                    const Duration(milliseconds: 750),
                                pageBuilder: (_, __, ___) =>
                                    CounsellorDialogBox(
                                  title: title,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: screenHeight * 0.03),
                            child: Hero(
                              tag: "counsellorcCard$title",
                              child: counsellorCard(
                                  screenHeight, screenWidth, title),
                            ),
                          ),
                        );
                      }).toList(),
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
