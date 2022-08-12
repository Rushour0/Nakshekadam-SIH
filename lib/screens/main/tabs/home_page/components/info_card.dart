import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/card_text.dart';

Card infoCard(
        double screenWidth, double screenHeight, String cardName, bool isOdd) =>
    Card(
      color: (isOdd)
          ? COLOR_THEME['backgroundComponents0']
          : COLOR_THEME['backgroundComponents1'],
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
                infoMap()[cardName]!,
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.04,
                  color: (isOdd) ? Colors.grey[600] : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
