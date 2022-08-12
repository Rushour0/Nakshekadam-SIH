import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';

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
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.007),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: optionNames.map((e) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, e);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/features_images/$e.png",
                            width: screenWidth * 0.175,
                            height: screenHeight * 0.1),
                        Text(
                          (e.replaceAll('_', '\n')).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Cabin",
                              color: COLOR_THEME["optionButtonText"]),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: const CustomCarouselSlider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
