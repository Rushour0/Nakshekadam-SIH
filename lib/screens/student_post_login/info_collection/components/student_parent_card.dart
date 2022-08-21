import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/strings.dart';

Card studentParentCard(double screenHeight, double screenWidth, String role) => Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        screenHeight * 0.01,
      ),
    ),
    color: (role.toLowerCase() == "student")
        ? const Color(0xFFFED7D7)
        : const Color(0xFFC1EFFF),
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "$POST_LOGIN_IMAGES/${role.toLowerCase()}Image.png",
            width: screenWidth * 0.3,
            height: screenWidth * 0.3,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: Text(
              role,
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
