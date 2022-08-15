import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_buttons.dart';
import 'package:nakshekadam/screens/main/tabs/resources_page/components/resource_card.dart';
import 'package:nakshekadam/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

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

    List<String> resourceNames = [
      'SWAYAM',
      'e-Kalpa',
      'Sakshat',
      'e-PGathshala',
      'e-Pathshala',
      'National Digital Library of India',
      'e-SkillIndia',
      'DIKSHA',
      'Curriculum Classes',
      'NPTEL',
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04),
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
                        left: screenWidth * 0.05, bottom: screenHeight * 0.015,top:screenWidth * 0.035),
                    child: Text(
                      "RESOURCES",
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: screenHeight * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    children: resourceNames.map((title) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: ResourceCard(title: title),
                      );
                    }).toList(),
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
