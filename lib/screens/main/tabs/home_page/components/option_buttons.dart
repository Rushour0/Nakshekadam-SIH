import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Row optionButtons(
        List<String> optionNames, double screenWidth, double screenHeight) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: optionNames.map((e) {
        return GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, e);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("$FEATURES_IMAGES_DIRECTORY/$e.png",
                  width: screenWidth * 0.175, height: screenHeight * 0.1),
              Text(
                (e.replaceAll('_', '\n')).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Cabin",
                    color: COLOR_THEME["optionButtonText"]),
              )
            ],
          ),
        );
      }).toList(),
    );
