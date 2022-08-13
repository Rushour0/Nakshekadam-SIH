import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/strings.dart';
import 'package:readmore/readmore.dart';

Card careerOptionsInfoCard(
        double screenWidth, double screenHeight, String cardName) =>
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
                cardName,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                stringData[cardName]!,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.0375,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
