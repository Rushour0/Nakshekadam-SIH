import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam/common_utils/bigThreeBg.dart';
import 'package:nakshekadam/common_utils/customPageRouter.dart';
import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
import 'package:nakshekadam/services/Firebase/FireAuth/fireauth.dart';
import 'package:nakshekadam/globals.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  List<String> roles = [
    'Student',
    'Parent',
    'Counselor',
  ];
  String? selectedRole = null;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
            if (_formKey.currentState!.validate()) {}
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
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.34),
                        child: Text(
                          "PERSONAL DETAILS",
                          style: TextStyle(
                            fontFamily: "Balsamiq Sans",
                            fontSize: screenWidth * 0.06,
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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.025),
                                    child: TextFormField(
                                      controller: nameController,
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter your name";
                                        } else {
                                          return null;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Full Name",
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.025),
                                    child: TextFormField(
                                      controller: phoneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your number";
                                        } else if (value.length != 10) {
                                          return "Mobile number is 10 length long";
                                        } else if (!(value[0] == '6' ||
                                            value[0] == '7' ||
                                            value[0] == '8' ||
                                            value[0] == '9')) {
                                          return "Invalid mobile number";
                                        } else {
                                          return null;
                                        }
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.025),
                                    child: TextFormField(
                                      controller: ageController,
                                      validator: (value) {
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .singleLineFormatter,
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Age",
                                        filled: true,
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.025,
                                      bottom: screenHeight * 0.2,
                                    ),
                                    // child: ,
                                    // child: DropdownButtonFormField<String>(

                                    //   decoration: InputDecoration(
                                    //     suffixIcon: Icon(
                                    //       Icons.arrow_drop_down,
                                    //       size: screenWidth * 0.12,
                                    //       color: Colors.grey,
                                    //     ),
                                    //     hintText: "Age",
                                    //     filled: true,
                                    //     fillColor: Colors.white,
                                    //     enabledBorder: OutlineInputBorder(
                                    //       borderSide: const BorderSide(
                                    //           color: Colors.grey),
                                    //       borderRadius: BorderRadius.circular(
                                    //           screenWidth * 0.05),
                                    //     ),
                                    //     errorBorder: OutlineInputBorder(
                                    //       borderSide: const BorderSide(
                                    //           color: Colors.grey),
                                    //       borderRadius: BorderRadius.circular(
                                    //           screenWidth * 0.05),
                                    //     ),
                                    //     focusedErrorBorder: OutlineInputBorder(
                                    //       borderSide: const BorderSide(
                                    //           color: Colors.grey),
                                    //       borderRadius: BorderRadius.circular(
                                    //           screenWidth * 0.05),
                                    //     ),
                                    //     focusedBorder: OutlineInputBorder(
                                    //       borderSide: const BorderSide(
                                    //           color: Colors.grey),
                                    //       borderRadius: BorderRadius.circular(
                                    //         screenWidth * 0.05,
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   validator: (value) {
                                    //     if (value == null) {
                                    //       return "Please select role";
                                    //     } else {
                                    //       return null;
                                    //     }
                                    //   },
                                    //   hint: const Text("Continue as"),
                                    //   value: selectedRole,
                                    //   dropdownColor: Colors.white,
                                    //   icon: const SizedBox.shrink(),
                                    //   items: roles.map((String items) {
                                    //     return DropdownMenuItem<String>(
                                    //       value: items,
                                    //       child: Text(items),
                                    //     );
                                    //   }).toList(),
                                    //   onChanged: (String? newValue) {
                                    //     setState(() {
                                    //       selectedRole = newValue!;
                                    //     });
                                    //   },
                                    // ),
                                  ),
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
    );
  }
}
