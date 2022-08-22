import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  String errorTextEmail = '',
      errorTextPassword = '',
      errorTextConfirmPassword = '';

  bool isValidEmail(String input) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  Future<void> register() async {
    if (_formkey.currentState!.validate() && nameController.text == "") {
      return;
    }
    if (confirmPasswordController.text != passwordController.text) {
      errorTextPassword = errorTextConfirmPassword = "Passwords do not match!";
    } else {
      List<dynamic> result = await registerUser(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text);
      print(result);
      if (result[0] == 1) {
        errorTextEmail = result[1];
      } else if (result[0] == 2) {
        errorTextPassword = result[1];
      } else if (result[0] == -1) {
        AlertDialog(
          title: const Text('Error occurred!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(result[1]),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      } else if (result[0] == 0) {
        // if ((await checkAdmin())!) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/admin_main_page', (route) => false);
        // }
        // await userDocumentReference().update({
        //   'name': nameController.text,
        //   // "email": emailController.text,
        //   // 'formFilled': false,
        //   // 'role': 'user',
        // });
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        passwordController.text =
            confirmPasswordController.text = emailController.text = '';
      }
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
            await register();
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
                                Navigator.pushNamed(context, '/login');
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              child: Text(
                                "LOGIN",
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
                          "CREATE YOUR ACCOUNT",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff32324D),
                          ),
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
                                  key: _formkey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.02),
                                        child: normalformfield(
                                            nameController,
                                            screenWidth,
                                            setState,
                                            "Full Name",
                                            TextInputType.name),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.025),
                                        child: emailformfield(
                                            emailController,
                                            screenWidth,
                                            setState,
                                            errorTextEmail),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.025),
                                        child: PasswordFormField(
                                            passwordController:
                                                passwordController,
                                            errorTextPassword:
                                                errorTextPassword,
                                            hintText: "Password"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.025),
                                        child: PasswordFormField(
                                            passwordController:
                                                confirmPasswordController,
                                            errorTextPassword:
                                                errorTextPassword,
                                            hintText: "Confirm Password"),
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
                                      bottom: screenHeight * 0.2),
                                  child: GestureDetector(
                                    onTap: (() async {
                                      print("name : ${nameController.text}");
                                      if (nameController.text == "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("Please enter your name"),
                                          ),
                                        );
                                        return;
                                      } else if (await signInWithGoogle(
                                          nameController.text)) {
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
                                        // await userDocumentReference().update({
                                        //   'name': nameController.text,
                                        // });
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/mobno',
                                            (route) => false);
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
                                              "SIGN UP WITH GOOGLE",
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
