import 'package:flutter/material.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/components/test_done_dialogbox.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/take_test.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:nakshekadam/strings.dart';

class studentTestCard extends StatefulWidget {
  const studentTestCard({
    Key? key,
    required this.title,
    required this.index,
  }) : super(key: key);
  final String title;
  final int index;

  @override
  State<studentTestCard> createState() => _studentTestCardState();
}

class _studentTestCardState extends State<studentTestCard> {
  UserDetailsModelOne userDetailsModelOne = UserDetailsModelOne.getModel();
  List<int> futureTestGiven = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDocumentReference().get().then((value) {
      UserDetailsModelOne.fromMap(value.data()!);
      setState(() {
        // print("usermodel : $userDetailsModelOne");
      });
    });
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenHeight * 0.01,
        ),
      ),
      color: (widget.index == 0 || widget.index == 3)
          ? COLOR_THEME["backgroundComponents1"]
          : COLOR_THEME["backgroundComponents2"],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "$TESTS_CARD_IMAGES/${widget.title.toLowerCase()}.png",
                  width: screenWidth * 0.215,
                  height: screenWidth * 0.215,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.001),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      widget.title,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF4D4288),
                        fontSize: screenHeight * 0.03,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.001),
              child: GestureDetector(
                onTap: () {
                  if (widget.title == "Aptitude") {
                    print(userDetailsModelOne.testGiven[0]);
                    if (userDetailsModelOne.testGiven[0] == 1) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 750),
                          pageBuilder: (_, __, ___) => TestGivenDialogBox(
                            title:
                                "You have already given ${widget.title} Test",
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (widget.title == "Aptitude")
                              ? TakeTest(testName: "Reasoning")
                              : TakeTest(testName: "${widget.title} Test"),
                        ),
                      );
                    }
                  } else if (widget.title == "Interest") {
                    if (userDetailsModelOne.testGiven[3] == 1) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 750),
                          pageBuilder: (_, __, ___) => TestGivenDialogBox(
                            title:
                                "You have already given ${widget.title} Test",
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (widget.title == "Aptitude")
                              ? TakeTest(testName: "Reasoning")
                              : TakeTest(testName: "${widget.title} Test"),
                        ),
                      );
                    }
                  } else if (widget.title == "Background") {
                    if (userDetailsModelOne.testGiven[2] == 1) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 750),
                          pageBuilder: (_, __, ___) => TestGivenDialogBox(
                            title:
                                "You have already given ${widget.title} Test",
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (widget.title == "Aptitude")
                              ? TakeTest(testName: "Reasoning")
                              : TakeTest(testName: "${widget.title} Test"),
                        ),
                      );
                    }
                  } else if (widget.title == "Personality") {
                    if (userDetailsModelOne.testGiven[1] == 1) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          opaque: false,
                          transitionDuration: const Duration(milliseconds: 750),
                          pageBuilder: (_, __, ___) => TestGivenDialogBox(
                            title:
                                "You have already given ${widget.title} Test",
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => (widget.title == "Aptitude")
                              ? TakeTest(testName: "Reasoning")
                              : TakeTest(testName: "${widget.title} Test"),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: COLOR_THEME["bottomNavigation"],
                  child: Center(
                    child: Text(
                      "Take test",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.028,
                        fontFamily: "Cabin",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
