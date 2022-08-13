import 'package:flutter/material.dart';

class WTThree extends StatelessWidget {
  const WTThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];
    return Scaffold(
      // floatingActionButton: Wrap(
      //   children: [
      //     SizedBox(
      //       width: screenWidth * 0.9,
      //       height: screenHeight * 0.06,
      //       child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           primary: const Color(0xff615793),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(screenHeight * 0.01),
      //           ),
      //         ),
      //         onPressed: () {},
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Text(
      //               "SIGN UP",
      //               style: TextStyle(
      //                 fontFamily: 'Cabin',
      //                 fontSize: screenWidth * 0.06,
      //                 color: const Color(0xffA5A5BA),
      //               ),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(left: screenWidth * 0.24),
      //               child: Icon(
      //                 CupertinoIcons.arrow_right,
      //                 color: const Color(0xffA5A5BA),
      //                 size: screenWidth * 0.07,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       width: screenWidth * 0.9,
      //       height: screenHeight * 0.04,
      //       child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //         Text(
      //           "Already have an account? ",
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //             fontFamily: "Nunito",
      //             fontSize: screenWidth * 0.045,
      //             fontWeight: FontWeight.w500,
      //             color: Colors.black,
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () {},
      //           child: Text(
      //               "Login",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 decoration: TextDecoration.underline,
      //                 fontFamily: "Nunito",
      //                 fontSize: screenWidth * 0.045,
      //                 fontWeight: FontWeight.w500,
      //                 fontStyle: FontStyle.italic,
      //                 color: const Color(0xff1A67F9),
      //               ),
      //             ),
      //         ),
      //       ]),
      //     )
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
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
            Positioned(
              top: screenHeight * 0.15,
              height: screenWidth * 0.62,
              right: 0,
              left: 0,
              child: Container(
                width: screenWidth * 0.62,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wtImageThree.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.43,
              width: screenWidth * 0.92,
              left: screenWidth * 0.04,
              child: const Divider(
                thickness: 2,
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 0,
              width: screenWidth,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: Column(
                    children: [
                      // Container(
                      //   width: screenWidth * 0.6,
                      //   padding: EdgeInsets.only(top: screenHeight * 0.45),
                      //   child: SliderTheme(
                      //     data: SliderThemeData(
                      //       inactiveTrackColor: Colors.grey[200],
                      //       activeTrackColor: const Color(0xff615793),
                      //       trackHeight: screenHeight * 0.007,
                      //       thumbShape: const RoundSliderThumbShape(
                      //         enabledThumbRadius: 0,
                      //       ),
                      //       thumbColor: Colors.transparent,
                      //       overlayColor: Colors.transparent,
                      //       overlayShape: const RoundSliderOverlayShape(
                      //         overlayRadius: 0,
                      //       ),
                      //     ),
                      //     child: Slider(
                      //       value: 3,
                      //       min: 0,
                      //       max: 3,
                      //       onChanged: (value) {},
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.575),
                        // padding: EdgeInsets.only(top: screenHeight * 0.045),
                        child: Text(
                          "A one-stop personalized guide to navigate all your career related confusions - \nNaksheKADAM",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xff524B6B),
                          ),
                          textAlign: TextAlign.center,
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
    );
  }
}
