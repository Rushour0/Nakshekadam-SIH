import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

Padding domainWisePercentage(double screenHeight, double screenWidth,
        String stream, double percentage) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.6,
                  child: Text(
                    "$stream : ",
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "DM Sans",
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "${percentage * 100}%",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: COLOR_THEME['secondary'],
                inactiveTrackColor: Colors.black26,
                trackHeight: 10,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 0,
                ),
                thumbColor: Colors.black12,
                overlayColor: Colors.transparent,
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 0,
                ),
              ),
              child: Slider(
                value: percentage,
                min: 0,
                max: 1,
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
