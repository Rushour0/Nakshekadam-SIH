import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigTwoSmallOneBg.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauthMobileLink.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:pinput/pinput.dart';

class PhoneAuthOtp extends StatefulWidget {
  const PhoneAuthOtp({
    Key? key,
    required this.mobileNumber,
  }) : super(key: key);
  final String mobileNumber;

  @override
  State<PhoneAuthOtp> createState() => _PhoneAuthOtpState();
}

class _PhoneAuthOtpState extends State<PhoneAuthOtp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _otpController;
  late FocusNode _otpFocusNode;
  String _verificationCode = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _otpFocusNode = FocusNode();
    _verifyPhoneNumber();
  }

  _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${widget.mobileNumber}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        _otpController.text = credential.smsCode.toString();
        String statusCode = await linkMobile(credential);
        if (statusCode == "0") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Mobile number linked successfully"),
          ));
          // Navigator.of(context).push(CustomPageRouter(child: const NameSex()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(statusCode),
          ));
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationID, int? resendToken) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (_) {},
      // timeout: const Duration(seconds: 120),
      // codeAutoRetrievalTimeout: (String verificationID) {
      //   setState(() {
      //     _verificationCode = verificationID;
      //   });
      // },
    );
  }

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
            if (isValid) {}
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
                        padding: EdgeInsets.only(
                            top: screenHeight * 0.1,
                            bottom: screenHeight * 0.03),
                        child: Text(
                          "ENTER THE OTP SENT TO THE PHONE NUMBER *******${widget.mobileNumber.substring(widget.mobileNumber.length - 3)}",
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
                            child: Column(
                              children: [
                                Pinput(
                                  defaultPinTheme: PinTheme(
                                    width: screenWidth * 0.13,
                                    height: screenWidth * 0.14,
                                    textStyle: TextStyle(
                                        fontSize: screenWidth * 0.06,
                                        color:
                                            const Color.fromRGBO(30, 60, 87, 1),
                                        fontWeight: FontWeight.w600),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF0F0FF),
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.04),
                                    ),
                                  ),
                                  length: 6,
                                  focusNode: _otpFocusNode,
                                  controller: _otpController,
                                  smsCodeMatcher: _otpController.text,
                                  androidSmsAutofillMethod:
                                      AndroidSmsAutofillMethod.smsRetrieverApi,
                                  onChanged: (String value) async {
                                    if (value.length == 6) {
                                      String statusCode = await linkMobile(
                                          PhoneAuthProvider.credential(
                                              verificationId: _verificationCode,
                                              smsCode: value));
                                      if (statusCode == "0") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Mobile number linked successfully"),
                                        ));
                                        // Navigator.of(context)
                                        //     .push(CustomPageRouter(child: const NameSex()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(statusCode),
                                          ),
                                        );
                                      }
                                      await userDocumentReference().update({
                                        'mobile': widget.mobileNumber,
                                      });
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/postLogin', (route) => false);
                                    }
                                  },
                                  onSubmitted: (String pin) async {
                                    String statusCode = await linkMobile(
                                        PhoneAuthProvider.credential(
                                            verificationId: _verificationCode,
                                            smsCode: pin));
                                    if (statusCode == "0") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Mobile number linked successfully"),
                                      ));
                                      // Navigator.of(context)
                                      //     .push(CustomPageRouter(child: const NameSex()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(statusCode),
                                        ),
                                      );
                                    }
                                    userDocumentReference().update({
                                      'mobile': widget.mobileNumber,
                                    });
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        '/postLogin', (route) => false);
                                  },
                                  pinAnimationType: PinAnimationType.fade,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Edit Phone Number?",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontFamily: "Nunito",
                                          fontSize: screenWidth * 0.045,
                                          color: const Color(0xff1A67F9)),
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
          ],
        ),
      ),
    );
  }
}
