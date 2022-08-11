import 'package:nakshekadam/globals.dart';
import 'package:flutter/material.dart';

class NoItemsInTab extends StatelessWidget {
  const NoItemsInTab({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth / 6,
        screenHeight / 5,
        screenWidth / 6,
        0,
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceAround,
        alignment: WrapAlignment.spaceAround,
        runSpacing: screenHeight / 20,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'FigTree',
              color: COLOR_THEME['tertiary'],
              fontSize: screenHeight / 20,
            ),
          ),
        ],
      ),
    );
  }
}
