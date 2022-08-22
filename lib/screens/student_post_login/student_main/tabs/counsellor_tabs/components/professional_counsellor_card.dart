import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/strings.dart';

Card professionalCounsellorCard(
        double screenHeight, double screenWidth, String title, int index) =>
    Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenHeight * 0.01,
        ),
      ),
      color: COLOR_THEME['backgroundComponents${(index + 1) % 3}'],
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "$PROFESSIONAL_COUNSELLOR_IMAGES/image$index.png",
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF4D4288),
                  fontSize: screenWidth * 0.06,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
