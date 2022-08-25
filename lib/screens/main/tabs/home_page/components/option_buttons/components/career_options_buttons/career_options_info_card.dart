import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/strings.dart';
import 'package:readmore/readmore.dart';

Card careerOptionsInfoCard(double screenWidth, double screenHeight,
        String optionCardName, String title) =>
    Card(
      color: COLOR_THEME['bottomNavigation'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.04, horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Overview",
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: ReadMoreText(
                stringData[optionCardName][title]["overview"]!,
                textAlign: TextAlign.left,
                trimLines: 14,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: "Read More",
                trimExpandedText: " Read Less",
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.0375,
                  color: Colors.white,
                ),
                lessStyle: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "Cabin",
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
                moreStyle: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "Cabin",
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
