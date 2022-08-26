import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/bottom_sheet.dart';
import 'package:nakshekadam/screens/main/tabs/resources_page/components/resource_explore_button.dart';
import 'package:nakshekadam/strings.dart';

class TestimonyCard extends StatelessWidget {
  const TestimonyCard({
    Key? key,
    required this.name,
    required this.role,
    required this.testimony,
    required this.index,
  }) : super(key: key);
  final String name;
  final String role;
  final String testimony;
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
      color: COLOR_THEME["backgroundComponents$index"],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenHeight * 0.02,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/face.png",
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenHeight * 0.023,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.01),
                          child: Text(
                            role,
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8696BB),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, bottom: screenHeight * 0.02),
              child: Text(
                testimony,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenHeight * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
