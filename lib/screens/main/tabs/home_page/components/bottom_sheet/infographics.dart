import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/strings.dart';

Column infographicsAndText({
  required double screenWidth,
  required double screenHeight,
  required String routeName,
}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.02,
        ),
        child: Image.asset(
          '$BOTTOM_SHEETS_ILLUSTRATIONS_DIRECTORY/$routeName.png',
          width: screenWidth * 0.72,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.01,
          right: screenWidth * 0.1,
          left: screenWidth * 0.1,
        ),
        child: Text(
          stringData[routeName]['summary'] ?? "No data provided",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Cabin",
            fontSize: screenWidth * 0.038,
            color: Colors.grey[600],
          ),
        ),
      )
    ],
  );
}
