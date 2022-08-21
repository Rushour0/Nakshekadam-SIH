import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/customPageRouter.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;
  String errorTextEmail = '', errorTextPassword = '';

  Future<void> login() async {
    if (emailController.text == '' || passwordController.text == '') {
      return;
    }
    List<dynamic> result = await signInUser(
        email: emailController.text, password: passwordController.text);

    print(result);

    if (result[0] == 1) {
      errorTextEmail = result[1];
    } else if (result[0] == 2) {
      errorTextPassword = result[1];
    } else if (result[0] == 0) {
      // if ((await checkAdmin())!) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/admin_main_page', (route) => false);
      // }
      // if (await checkFormFilled()) {
      //   print("WHATS UP !");
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/main_page', (route) => false);
      // } else {
      // User _user = FirebaseAuth.instance.currentUser!;
      // if (_user.phoneNumber != null) {
      //   Navigator.of(context).push(CustomPageRouter(child: const NameSex()));
      // } else {
      if (await checkFormFilled()) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/postLogin', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/postLoginMain', (route) => false);
      }
      // }}
    }
    setState(() {});
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
          onPressed: () async {
            await login();
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
              child: const BigThreeBG(),
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
                                Navigator.pushNamed(context, '/signup');
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                "SIGN UP",
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
                        padding: EdgeInsets.only(top: screenHeight * 0.27),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.08,
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
                                Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: screenHeight * 0.02),
                                          child: emailformfield(
                                              emailController,
                                              screenWidth,
                                              setState,
                                              errorTextEmail)),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.025),
                                        child: PasswordFormField(
                                          passwordController:
                                              passwordController,
                                          errorTextPassword: errorTextPassword,
                                          hintText: "Password",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.05),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.4,
                                            child: const Divider(
                                              color: Color(0xff756F86),
                                              thickness: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.4,
                                            child: const Divider(
                                              color: Color(0xff756F86),
                                              thickness: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "OR",
                                          style: TextStyle(
                                            fontFamily: "DM Sans",
                                            fontSize: screenWidth * 0.04,
                                            color: const Color(0xff756F86),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenHeight * 0.025,
                                      bottom: screenHeight * 0.1),
                                  child: GestureDetector(
                                    onTap: (() async {
                                      if (await signInWithGoogle("")) {
                                        // bool isAdmin = (await checkAdmin())!;
                                        // if (isAdmin) {
                                        //   print("I AM ADMIN");
                                        //   Navigator.pushNamedAndRemoveUntil(context,
                                        //       '/admin_main_page', (route) => false);
                                        // } else if (await checkFormFilled()) {
                                        //   print("WHATS UP !");
                                        //   Navigator.pushNamedAndRemoveUntil(
                                        //       context, '/main_page', (route) => false);
                                        // } else {
                                        if (await checkFormFilled()) {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/postLoginMain',
                                              (route) => false);
                                        } else {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              '/postLogin',
                                              (route) => false);
                                        }
                                        // }
                                      }
                                    }),
                                    child: Card(
                                      elevation: 5,
                                      color: const Color(0xffDCDCE4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.03),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.02),
                                        width: screenWidth * 0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: screenWidth * 0.09,
                                              width: screenWidth * 0.09,
                                              padding: EdgeInsets.only(
                                                  right: screenWidth * 0.03),
                                              child: Tab(
                                                icon: SvgPicture.asset(
                                                  "assets/images/google.svg",
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "LOG IN WITH GOOGLE",
                                              style: TextStyle(
                                                fontFamily: "DM Sans",
                                                fontSize: screenWidth * 0.045,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff130160),
                                              ),
                                            )
                                          ],
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
