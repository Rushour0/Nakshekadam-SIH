import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
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

    List<String> infoCardNames = [
      'Our Vision',
      'About DoESL',
      "New Education Policy' 20 - Transforming India",
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.007),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OptionButtons(
                    optionNames: optionNames,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: const CustomCarouselSlider(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.12),
                    child: Column(
                      children: infoCardNames.map((name) {
                        int index = infoCardNames.indexOf(name);
                        return Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.03),
                          child:
                              infoCard(screenWidth, screenHeight, name, index),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
