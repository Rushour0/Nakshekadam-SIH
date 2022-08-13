import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/bottom_sheet.dart';

class OptionButtons extends StatelessWidget {
  const OptionButtons({
    Key? key,
    required this.optionNames,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);
  final List<String> optionNames;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: optionNames.map((optionName) {
        return GestureDetector(
          onTap: () async {
            // Navigator.pushNamed(context, e);
            await showModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.85,
                ),
                isScrollControlled: true,
                // enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    screenWidth,
                  ),
                ),
                backgroundColor: Colors.transparent,
                context: context,
                builder: (builder) {
                  return CustomBottomSheet(
                    routeName: optionName,
                  );
                });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("$FEATURES_IMAGES_DIRECTORY/$optionName.png",
                  width: screenWidth * 0.175, height: screenHeight * 0.1),
              Text(
                (optionName.replaceAll('_', '\n')).toUpperCase(),
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
  }
}
