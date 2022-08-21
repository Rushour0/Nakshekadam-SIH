import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigTwoSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/customPageRouter.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/screens/verification&details/mobileVerification/phone_auth_otp.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff615793),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.01),
            ),
          ),
          onPressed: () {
            final isValid = _formKey.currentState!.validate();
            if (isValid) {
              Navigator.of(context).push(
                CustomPageRouter(
                  child: PhoneAuthOtp(
                    mobileNumber: phoneController.text.trim(),
                  ),
                ),
              );
            }
          },
          child: Text(
            "CONTINUE",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenWidth * 0.06,
              color: const Color(0xffA5A5BA),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: screenHeight,
              width: screenWidth,
              child: const BigTwoSmallOneBG(),
            ),
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
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                "BACK",
                                style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff615793),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/postLogin');
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
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
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.05),
                        child: Image.asset(
                          'assets/images/verifyCenterImage.png',
                          width: screenWidth * 0.7,
                          height: screenWidth * 0.7,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                        child: Text(
                          "VERIFY YOUR CONTACT",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff32324D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: screenHeight * 0.02),
                                child: phoneformfield(
                                    phoneController, screenWidth, setState),
                              ),
                            ),
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
    );
  }
}
