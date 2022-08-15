import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Card upcomingExamsCardButton(double screenHeight, double screenWidth) => Card(
      color: COLOR_THEME["bottomNavigation"],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.01, horizontal: screenWidth * 0.05),
        child: Text(
          "More Details",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
