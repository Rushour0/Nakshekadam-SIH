import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/bottom_sheet.dart';

import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_option_bottom_sheet.dart';

class OptionButtons extends StatelessWidget {
  const OptionButtons({
    Key? key,
    required this.optionNames,
  }) : super(key: key);
  final List<String> optionNames;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: optionNames.map((optionName) {
        return GestureDetector(
          onTap: () async {
            // Navigator.pushNamed(context, optionName);
            await showModalBottomSheet(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.95,
                ),
                isScrollControlled: true,
                isDismissible: false,
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

            // await showModalBottomSheet(
            //     constraints: BoxConstraints(
            //       maxHeight: screenHeight * 0.85,
            //     ),
            //     isScrollControlled: true,
            //     // enableDrag: false,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(
            //         screenWidth,
            //       ),
            //     ),
            //     backgroundColor: Colors.transparent,
            //     context: context,
            //     builder: (builder) {
            //       return CareerOptionBottomSheet(
            //         routeName: "STEM",
            //         optionCardName: optionName,
            //       );
            //     });
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
