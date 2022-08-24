import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:nakshekadam/globals.dart';

class TestExpansionTile extends StatelessWidget {
  const TestExpansionTile({
    Key? key,
    required this.percentage,
  }) : super(key: key);
  final double percentage;

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        collapsedBackgroundColor: COLOR_THEME["careerTile"],
        backgroundColor: COLOR_THEME["careerTile"],
        title: Text(
          "Aptitude",
          style: TextStyle(
            fontFamily: "DM Sans",
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        children: [
          Text(
            "STEM",
            style: TextStyle(
              fontFamily: "DM Sans",
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05,
              color: Colors.black,
            ),
          ),
          SliderTheme(
            data: SliderThemeData(
              inactiveTrackColor: COLOR_THEME['secondary'],
              activeTrackColor: Colors.black26,
              trackHeight: 10,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 0,
              ),
              thumbColor: Colors.black12,
              overlayColor: Colors.transparent,
              overlayShape: const RoundSliderOverlayShape(
                overlayRadius: 0,
              ),
              trackShape: const RectangularSliderTrackShape(),
            ),
            child: Slider(
              value: percentage,
              min: 0,
              max: 1,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
