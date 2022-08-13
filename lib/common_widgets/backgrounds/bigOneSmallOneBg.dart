import 'package:flutter/material.dart';

class BigOneSmallOneBG extends StatelessWidget {
  const BigOneSmallOneBG({Key? key}) : super(key: key);

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
              right: 0,
              height: screenWidth * 0.57 + screenHeight * 0.035,
              child: Container(
                width: screenWidth * 0.57,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/topRightCircle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.45,
              left: 0,
              height: screenWidth * 0.25 * 2,
              child: Container(
                width: screenWidth * 0.25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/centerLeftCircle.png'),
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
                    fit: BoxFit.contain,
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
