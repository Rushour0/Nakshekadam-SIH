import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_options_info_card.dart';
import 'package:nakshekadam/strings.dart';

Column careerOptionsInfographicsAndText({
  required double screenWidth,
  required double screenHeight,
  required String title,
  required String optionCardName,
}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.02,
        ),
        child: Image.asset(
          '$CAREER_OPTIONS_BOTTOM_SHEETS_ILLUSTRATIONS_DIRECTORY/$title.png',
          width: screenWidth * 0.9,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        child: careerOptionsInfoCard(screenWidth, screenHeight, optionCardName),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.02,
        ),
        child: Text(
          "Discover the various degree options, colleges and examinations related to this domain!",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "DM Sans",
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.005,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              title: Text(
                      "Subjects",
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
              trailing: Icon(Icons.keyboard_arrow_down_sharp),
              backgroundColor: COLOR_THEME['careerTile'],
              collapsedBackgroundColor: COLOR_THEME['careerTile'],
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.01,
                  ),
                  color: COLOR_THEME['careerTileExpanded'],
                  child: Text(
                      '''This domain can be explored with combinations of subjects involving -\n
            • Physics\n
            • Chemistry\n
            • Mathematics\n
            • Biology
          '''),
                )
              ],
            ),
        ),
      ),
    ],
  );
}
