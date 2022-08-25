import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_dialogbox_button.dart';
import 'package:nakshekadam/strings.dart';

class TestGivenDialogBox extends StatelessWidget {
  const TestGivenDialogBox({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      elevation: 2,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: screenHeight * 0.03,
            top: screenHeight * 0.04,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05),
        child: Column(
          children: [
            Icon(Icons.celebration_rounded,
                size: screenWidth * 0.5,
                color: COLOR_THEME['backgroundComponents0']),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "DM Sans",
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/displayTestResult');
                },
                child: Card(
                  color: COLOR_THEME['buttonBackground'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.01),
                    child: Text(
                      "Show Result",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DM Sans",
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
