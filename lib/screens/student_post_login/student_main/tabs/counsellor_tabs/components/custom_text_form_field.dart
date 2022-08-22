import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

customTextField(
        String title, String text, double screenHeight, double screenWidth) =>
    Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: RichText(
        text: TextSpan(
          text: "$title : ",
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: COLOR_THEME["descriptionText"],
          ),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.05,
                color: COLOR_THEME["descriptionText"],
              ),
            ),
          ],
        ),
      ),
    );
