import 'package:flutter/material.dart';

class WTOne extends StatelessWidget {
  const WTOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];
    return Scaffold(
      // floatingActionButton: SizedBox(
      //   width: screenWidth * 0.9,
      //   height: screenHeight * 0.06,
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       primary: const Color(0xff615793),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(screenHeight * 0.01),
      //       ),
      //     ),
      //     onPressed: () {
      //       Navigator.of(context)
      //                     .push(CustomPageRouter(child: const WTTwo()));
      //     },
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         Text("NEXT",
      //           style: TextStyle(
      //             fontFamily: 'Cabin',
      //             fontSize: screenWidth * 0.06,
      //             color: const Color(0xffA5A5BA),
      //           ),),
      //         Padding(
      //           padding: EdgeInsets.only(left: screenWidth * 0.28),
      //           child: Icon(
      //             CupertinoIcons.arrow_right,
      //             color: const Color(0xffA5A5BA),
      //             size: screenWidth * 0.07,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
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
              top: screenHeight * 0.4,
              right: 0,
              height: screenWidth * 0.45 * 2,
              child: Container(
                width: screenWidth * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/centerRightCircle.png'),
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
                    image: AssetImage('assets/images/wtImageOne.png'),
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
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text(
                            "SKIP",
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff615793),
                            ),
                          ),
                        ),
                      ),
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
                      //       value: 1,
                      //       min: 0,
                      //       max: 3,
                      //       onChanged: (value) {},
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.5),
                        // padding: EdgeInsets.only(top: screenHeight * 0.04),
                        child: Text(
                          "Welcome to NaksheKADAM",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff32324D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Text(
                          "Confused about what path to take in your career?",
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
