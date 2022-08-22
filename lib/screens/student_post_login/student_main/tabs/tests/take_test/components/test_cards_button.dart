import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Card testCardsButton(double screenHeight, double screenWidth) => Card(
      color: COLOR_THEME["bottomNavigation"],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.006, horizontal: screenWidth * 0.06),
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: screenHeight * 0.025,
            color: Colors.white,
          ),
        ),
      ),
    );
