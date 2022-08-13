import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_options_infographics.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/infographics.dart';
import 'package:nakshekadam/strings.dart';

class CareerOptionBottomSheet extends StatelessWidget {
  const CareerOptionBottomSheet({
    Key? key,
    required this.routeName,
    required this.optionCardName,
  }) : super(key: key);
  final String routeName;
  final String optionCardName;

  @override
  Widget build(BuildContext context) {
    String title = routeName.replaceAll('_', ' ').toUpperCase();
    print(title);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            screenWidth / 20,
          ),
          topRight: Radius.circular(
            screenWidth / 20,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          commonBottomSheetTitle(
            title: title,
            screenWidth: screenWidth,
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                child: Wrap(
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.center,
                  spacing: screenWidth * 0.05,
                  runSpacing: screenHeight * 0.02,
                  children: [
                    careerOptionsInfographicsAndText(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      routeName: routeName,
                      optionCardName : optionCardName
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

commonBottomSheetTitle({required title, required screenWidth}) {
  TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: "DM Sans",
    fontSize: screenWidth * 0.07,
    fontWeight: FontWeight.bold,
  );

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 2.75,
          vertical: screenWidth * 0.05,
        ),
        child: Container(
          width: screenWidth,
          height: screenWidth * 0.02,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(
              screenWidth / 30,
            ),
          ),
        ),
      ),
      Container(
        color: COLOR_THEME['primary'],
        width: screenWidth,
        height: screenWidth * 0.14,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
        ),
      ),
    ],
  );
}
