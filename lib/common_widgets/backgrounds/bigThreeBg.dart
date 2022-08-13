import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/common_widgets/customPageRouter.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
import 'package:nakshekadam/globals.dart';

class BigThreeBG extends StatelessWidget {
  const BigThreeBG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              height: screenWidth * 0.45 + screenHeight * 0.04,
              child: Container(
                width: screenWidth * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/topLeftCircle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.35,
              right: 0,
              height: screenWidth * 0.4 * 2,
              child: Container(
                width: screenWidth * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/centerRightCircle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.55,
              left: 0,
              height: screenWidth * 0.4 * 2,
              child: Container(
                width: screenWidth * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/centerLeftBigCircle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -screenHeight * 0.18,
              height: screenWidth * 2,
              right: 0,
              left: 0,
              child: Container(
                width: screenWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/centerCircles.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.03,
              height: screenWidth * 0.8,
              right: 0,
              left: 0,
              child: Container(
                width: screenWidth * 0.8,
                decoration: const BoxDecoration(
                  // color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/images/naksheKADAM.png'),
                    fit: BoxFit.fitWidth,
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
