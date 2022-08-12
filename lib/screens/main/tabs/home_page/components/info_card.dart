import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Card info_card(double screenWidth, double screenHeight, String cardName) => Card(
      color: COLOR_THEME['backgroundComponents'],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.04,
            horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Text(
              cardName,
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                cardName.replaceAll(" ", "_").replaceAll("'", "").replaceAll("-", "").toUpperCase(),
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
