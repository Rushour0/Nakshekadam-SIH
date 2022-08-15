import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/strings.dart';

Card testCard(double screenHeight, double screenWidth, String title, int index) => Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenHeight * 0.01,
        ),
      ),
      color: (index == 0 || index == 3) ? COLOR_THEME["backgroundComponents1"] : COLOR_THEME["backgroundComponents2"],
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "$TESTS_CARD_IMAGES/${title.toLowerCase()}.png",
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF4D4288),
                    fontSize: screenHeight * 0.03,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
