import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam/common_widgets/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/customPageRouter.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/globals.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              width: screenWidth,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Image.asset(
                              //   "$FEATURES_IMAGES_DIRECTORY/career_options.png",
                              // ),
                              Text(
                                "CAREER\nOPTIONS",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Cabin",
                                    color: COLOR_THEME["optionButtonText"]),
                              )
                            ],
                          )
                        ],
                      ),
                      CustomCarouselSlider(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
