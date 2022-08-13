import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/card_text.dart';
import 'package:readmore/readmore.dart';

Card infoCard(
        double screenWidth, double screenHeight, String cardName, int index) =>
    Card(
      color: COLOR_THEME['backgroundComponents$index'],
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
              child: ReadMoreText(
                infoMap[cardName]!,
                textAlign: TextAlign.left,
                trimLines: 3,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: "Read More",
                trimExpandedText: " Read Less",
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.0375,
                  color: Colors.black,
                ),
                lessStyle: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.04,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic
                ),
                moreStyle: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.04,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic
                ),
                callback: (val) => print(val),
              ),
            ),
          ],
        ),
      ),
    );
