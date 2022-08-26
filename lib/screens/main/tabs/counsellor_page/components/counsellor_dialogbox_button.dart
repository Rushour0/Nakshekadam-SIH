import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Card counsellorDialogBoxButton(
        double screenHeight, double screenWidth, String buttontext) =>
    Card(
      color: buttontext == 'Reported'
          ? Colors.red.shade400
          : COLOR_THEME["bottomNavigation"],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
      ),
      child: SizedBox(
        width: screenWidth * 0.8,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01, horizontal: screenWidth * 0.05),
          child: Text(
            buttontext.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
