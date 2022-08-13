import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/career_options_buttons/career_options_infoCard.dart';
import 'package:nakshekadam/strings.dart';

Column careerOptionsInfographicsAndText({
  required double screenWidth,
  required double screenHeight,
  required String routeName,
  required String optionCardName,
}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.02,
        ),
        child: Image.asset(
          '$CAREER_OPTIONS_BOTTOM_SHEETS_ILLUSTRATIONS_DIRECTORY/$routeName.png',
          width: screenWidth * 0.9,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
        ),
        child: careerOptionsInfoCard(screenWidth, screenHeight, optionCardName),
      ),
    ],
  );
}
