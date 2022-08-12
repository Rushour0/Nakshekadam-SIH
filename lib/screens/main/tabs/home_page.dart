import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/card_text.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> optionNames = [
      'career_options',
      'industries',
      'upcoming_exams',
      'scholarships',
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: screenHeight * 0.007),
            child: Column(
              children: [
                optionButtons(optionNames, screenWidth, screenHeight),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03),
                  child: const CustomCarouselSlider(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03, bottom: screenHeight * 0.03),
                  child: Card(
                    color: COLOR_THEME['backgroundComponents'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.05),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "About DoESL",
                                style: TextStyle(
                                  fontFamily: "DM Sans",
                                  fontSize: screenWidth * 0.08,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.02),
                            child: Text(
                              ABOUT_DOESL,
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
