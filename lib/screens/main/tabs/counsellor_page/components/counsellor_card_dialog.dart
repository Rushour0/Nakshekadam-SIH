import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_dialogbox_button.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/professional_counsellor.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
import 'package:nakshekadam/strings.dart';

class CounsellorDialogBox extends StatelessWidget {
  const CounsellorDialogBox({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Hero(
      tag: "counsellorcCard$title",
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        child: SizedBox(
          height: screenHeight * 0.75,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: screenHeight * 0.05),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.03, bottom: screenHeight * 0.02),
                  child: Container(
                    color: COLOR_THEME['primary'],
                    width: screenWidth,
                    height: screenWidth * 0.14,
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "DM Sans",
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "$COUNSELLOR_CARD_IMAGES/${title.toLowerCase()}.png",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    color: COLOR_THEME["backgroundComponents0"],
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Column(
                        children: [
                          Text(
                            stringData["counsellors"]["cards"]
                                [title.toLowerCase()]["description"],
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF4D4288),
                              fontSize: screenWidth * 0.042,
                              fontFamily: "Cabin",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.01),
                            child: GestureDetector(
                              onTap: () async {
                                if (title.toLowerCase() ==
                                        "professional counsellors" ||
                                    title.toLowerCase() ==
                                        "industrial experts") {
                                  if (await checkLoggedIn()) {
                                    print("logged in");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            (title.toLowerCase() ==
                                                    "professional counsellors")
                                                ? const ProfessionalCounsellor(
                                                    optionList: [
                                                      "Explore Counsellors",
                                                      "Connected Counsellors",
                                                      "Message history"
                                                    ],
                                                  )
                                                : const ProfessionalCounsellor(
                                                    optionList: [
                                                      "Explore Experts",
                                                      "Connected Experts",
                                                      "Message history"
                                                    ],
                                                  ),
                                      ),
                                    );
                                  } else {
                                    print("logged out");
                                    Navigator.pushNamed(context, "/signup");
                                  }
                                }
                              },
                              child: counsellorDialogBoxButton(
                                  screenHeight,
                                  screenWidth,
                                  stringData["counsellors"]["cards"]
                                      [title.toLowerCase()]["buttonTitle"]),
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
    );
  }
}
