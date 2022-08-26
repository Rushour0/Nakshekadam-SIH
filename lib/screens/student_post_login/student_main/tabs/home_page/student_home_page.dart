import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/main/main_page.dart';
import 'package:nakshekadam/screens/main/tabs/college_page/college_page.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_buttons.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/home_page/components/exam_not_given.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/home_page/components/play_yt_vid.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/home_page/components/testimony_carousel.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (UserDetailsModelOne.userDetailsModelOne.email == "") {
      userDocumentReference().get().then((value) {
        UserDetailsModelOne.fromMap(value.data()!);
        setState(() {
          // print("usermodel : $userDetailsModelOne");
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDetailsModelOne userDetailsModelOne = UserDetailsModelOne.getModel();
    print("checking userModel : $userDetailsModelOne");
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

    List<String> infoCardNames = [
      "Customised specially for you${userDetailsModelOne.question}",
    ];

    List<Map<String, dynamic>> vidMap = [
      {
        "title": "Sarvesh Mehtani",
        "subtitle": "(AIR -1 JEE Advanced 2017)",
        "desc":
            "Chandigarh boy, Sarvesh Mehtani grabbed the first rank in JEE Advanced 2017 scoring a total of 339 marks. Not an easy feat to accomplish, Sarvesh who hails from Panchkula has completed his studies from a CBSE background and had secured AIR 55 in JEE Mains 2017.",
        "link": "https://www.youtube.com/watch?v=aF-7yDAl2as",
      },
      {
        "title": "Kautilya Pandit",
        "subtitle": "All you need to know",
        "desc":
            "Kautilya Pandit is well-versed in mathematics, astronomy, general knowledge, current events, and a variety of other subjects and he known as Google Boy on social media and television. In addition, the youngster is a motivational speaker. Google Boy continues to amaze people with his knowledge and talent.",
        "link": "https://www.youtube.com/watch?v=_h3mZF1YvmE",
      }
    ];
    List<String> optionNames = [
      "COLLEGES",
      "EXAMS",
      "AI-INTERACTION",
      "SCHOLARSHIPS"
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: (userDetailsModelOne.name != "")
                        ? Text(
                            "Welcome ${userDetailsModelOne.name.split(" ")[0]}!",
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "Welcome!",
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Image.asset(
                    "assets/images/studentMain.png",
                    height: screenHeight * 0.2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recommended for you",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: optionNames.map((optionName) {
                      return GestureDetector(
                        onTap: (optionName == "COLLEGES")
                            ? () {
                                if (userDetailsModelOne.testGiven.contains(1)) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CollegePage(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      barrierDismissible: true,
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      opaque: false,
                                      transitionDuration:
                                          const Duration(milliseconds: 750),
                                      pageBuilder: (_, __, ___) =>
                                          ExamNotDialogBox(),
                                    ),
                                  );
                                }
                              }
                            : (optionName == "EXAMS")
                                ? () {
                                    if (userDetailsModelOne.testGiven
                                        .contains(1)) {
                                      Navigator.pushNamed(
                                          context, "/displayTestResult");
                                    } else {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          barrierDismissible: true,
                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          opaque: false,
                                          transitionDuration:
                                              const Duration(milliseconds: 750),
                                          pageBuilder: (_, __, ___) =>
                                              ExamNotDialogBox(),
                                        ),
                                      );
                                    }
                                  }
                                : (optionName == "SCHOLARSHIPS")
                                    ? () {
                                        if (userDetailsModelOne.testGiven
                                            .contains(1)) {
                                          Navigator.pushNamed(
                                              context, "/displayTestResult");
                                        } else {
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              barrierDismissible: true,
                                              barrierColor:
                                                  Colors.black.withOpacity(0.5),
                                              opaque: false,
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 750),
                                              pageBuilder: (_, __, ___) =>
                                                  ExamNotDialogBox(),
                                            ),
                                          );
                                        }
                                      }
                                    : () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                "$STUDENT_MAIN_OPTIONS/${optionName.toLowerCase()}.png",
                                width: screenWidth * 0.175,
                                height: screenHeight * 0.1),
                            Text(
                              optionName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Cabin",
                                  color: COLOR_THEME["optionButtonText"]),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(top: screenHeight * 0.01),
                  //   child: OptionButtons(
                  //     optionNames: optionNames,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: const CustomCarouselSlider(
                      imagePath: STUDENT_BANNER_IMAGE_DIRECTORY,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                    child: Column(
                      children: infoCardNames.map((name) {
                        int index = infoCardNames.indexOf(name);
                        return Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child:
                              infoCard(screenWidth, screenHeight, name, index),
                        );
                      }).toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Whats New?",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: vidMap.map((vid) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                PlayVid(
                                  link: vid["link"],
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(screenWidth / 30),
                                  topRight: Radius.circular(screenWidth / 30),
                                ),
                                child: PlayVid(
                                  link: vid["link"],
                                ),
                              ),
                            ),
                            Container(
                              color: (vidMap.indexOf(vid) == 0)
                                  ? Color(0xFFFFE3D5)
                                  : Color(0xFF8D4130),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth / 30,
                                  vertical: screenHeight / 60),
                              child: Column(
                                children: [
                                  Text(
                                    vid["title"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: (vidMap.indexOf(vid) == 0)
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Cabin",
                                      fontSize: screenWidth * 0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    vid["subtitle"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: (vidMap.indexOf(vid) == 0)
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: "Cabin",
                                      fontSize: screenWidth * 0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.02),
                                    child: Text(
                                      vid["desc"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: (vidMap.indexOf(vid) == 0)
                                            ? Colors.black
                                            : Colors.white,
                                        fontFamily: "Cabin",
                                        fontSize: screenWidth * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Whats New?",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.01, bottom: screenHeight * 0.2),
                    child: const TestimonyCarouselSlider(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
