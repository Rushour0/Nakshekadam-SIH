import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:nakshekadam/globals.dart';

class TestCard extends StatefulWidget {
  const TestCard({
    Key? key,
    required this.options,
    required this.question,
    required this.title,
    required this.answerEditor,
  }) : super(key: key);
  final List<String> options;
  final String question;
  final String title;
  final TextEditingController answerEditor;

  @override
  State<TestCard> createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
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
          "${widget.title} :",
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
                "Q ${widget.question}",
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Column(
                children: widget.options
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
                            setState(() {
                              widget.answerEditor.text = widget.options
                                  .indexOf(selectedOption!)
                                  .toString();
                            });
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
