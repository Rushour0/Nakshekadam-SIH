import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Card testButton(double screenHeight, double screenWidth, String buttontext) => Card(
      color: COLOR_THEME["bottomNavigation"],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: SizedBox(
        width: screenWidth * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01, horizontal: screenWidth * 0.05),
          child: Text(
            buttontext,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
        ),
      ),
    );
