import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/carousel.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_buttons.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List<String> optionNames = [
    'career_options',
    'industries',
    'upcoming_exams',
    'scholarships',
  ];

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
      'Our Vision',
      'About DoESL',
      "New Education Policy' 20 - Transforming India",
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
                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                    child: OptionButtons(
                      optionNames: optionNames,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: const CustomCarouselSlider(
                      imagePath: STUDENT_BANNER_IMAGE_DIRECTORY,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.15),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
