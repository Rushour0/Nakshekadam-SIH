import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/globals.dart';

class ReasoningCard extends StatefulWidget {
  const ReasoningCard({Key? key}) : super(key: key);

  @override
  State<ReasoningCard> createState() => _ReasoningCardState();
}

class _ReasoningCardState extends State<ReasoningCard> {
  final List<String> options = ["21", "41", "57", "27"];

  String? selectedOption;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reasoning :",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.w600,
            color: const Color(0xff32324D),
          ),
        ),
        Card(
          color: COLOR_THEME["careerTile"],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.03, horizontal: screenWidth * 0.03),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Q1. Look at this series: 53, 53, 40, 40, 27, 27, ... What number should come next?",
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Column(
                children: options
                    .map(
                      (option) => RadioListTile(
                          title: Text(
                            option,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenWidth * 0.05,
                              color: Colors.black,
                            ),
                          ),
                          value: option,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            selectedOption = value.toString();
                            setState(() {});
                          }),
                    )
                    .toList(),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: testCardsButton(screenHeight, screenWidth),
              // )
            ]),
          ),
        )
      ],
    );
  }
}
