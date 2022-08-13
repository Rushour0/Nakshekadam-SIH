import 'package:flutter/material.dart';

class WTTwo extends StatelessWidget {
  const WTTwo({Key? key}) : super(key: key);

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
      //                     .push(CustomPageRouter(child: const WTThree()));
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
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.035,
              left: 0,
              height: screenWidth * 0.45 + screenHeight * 0.035,
              child: Container(
                width: screenWidth * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/topLeftFullCircle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1,
              right: 0,
              height: screenWidth * 0.7 * 2,
              child: Container(
                width: screenWidth * 0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/centerRightFullCircle.png'),
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
              height: screenWidth * 0.55,
              right: 0,
              left: 0,
              child: Container(
                width: screenWidth * 0.55,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wtImageTwo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.41,
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
                      //       value: 2,
                      //       min: 0,
                      //       max: 3,
                      //       onChanged: (value) {},
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.57),
                        child: Text(
                          "Explore different fields using our advanced AI and make the best possible choice personalized for you!",
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
