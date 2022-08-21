import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/components/student_parent_card.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/parent_details_collection.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/student_details_collection.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class StudentParent extends StatelessWidget {
  const StudentParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> roleList = ["Student", "Parent"];
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
      body: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              height: screenWidth * 0.45 + screenHeight * 0.04,
              child: Container(
                width: screenWidth * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/topLeftCircle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.4,
              right: 0,
              height: screenWidth * 0.45 * 2,
              child: Container(
                width: screenWidth * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/centerRightCircle.png'),
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
              top: 0,
              width: screenWidth,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.12),
                        child: Text(
                          "Welcome to NaksheKADAM\nname!",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff32324D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.06,
                          left: screenWidth * 0.05,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Continue as",
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenWidth * 0.07,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xff32324D),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: roleList
                            .map(
                              (role) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015,
                                    horizontal: screenWidth * 0.05),
                                child: GestureDetector(
                                  onTap: (role.toLowerCase() == "student")
                                      ? () async {
                                          await userDocumentReference().update({
                                            'role': 'student',
                                          });
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  const StudentDetailsCollection()),
                                            ),
                                          );
                                        }
                                      : (role.toLowerCase() == "parent")
                                          ? () async {
                                              await userDocumentReference()
                                                  .update({
                                                'role': 'parent',
                                              });
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const ParentDetailsCollection()),
                                                ),
                                              );
                                            }
                                          : () {},
                                  child: studentParentCard(
                                      screenHeight, screenWidth, role),
                                ),
                              ),
                            )
                            .toList(),
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
