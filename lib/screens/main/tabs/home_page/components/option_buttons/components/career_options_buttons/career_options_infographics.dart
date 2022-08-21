import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_options_expansion_tiles.dart';
import 'package:nakshekadam/screens/trees/components/tree_json_text.dart';
import 'package:nakshekadam/screens/trees/tree_from_json.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_options_info_card.dart';
import 'package:nakshekadam/strings.dart';

class careerOptionsInfographicsAndText extends StatelessWidget {
  const careerOptionsInfographicsAndText({
    Key? key,
    required this.title,
    required this.optionCardName,
  }) : super(key: key);
  final String title;
  final String optionCardName;

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];
    Map<String, dynamic> _tilesData =
        stringData[optionCardName][title]["tiles"];
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
          child: careerOptionsInfoCard(
              screenWidth, screenHeight, optionCardName, title),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.02,
          ),
          child: Text(
            stringData[optionCardName][title]["middleLine"]!,
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
          child: Column(
              children: _tilesData.keys.map((key) {
            print(key);
            return CareerOptionExpansionTiles(
                tilesData: _tilesData,
                dataKey: key,
                title: title,
                optionCardName: optionCardName);
          }).toList()),
        ),
      ],
    );
  }
}
