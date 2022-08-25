import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/components/student_parent_card.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/student_details_collection.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/components/professional_counsellor_card.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/connected_counsellors/connected_counsellors.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/explore_experts_counsellors.dart';

class CounsellorORExpert extends StatelessWidget {
  const CounsellorORExpert({
    Key? key,
    required this.title,
    required this.optionList,
  }) : super(key: key);
  final List<String> optionList;
  final String title;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              height: screenHeight,
              width: screenWidth,
              child: const BigOneSmallOneBG(),
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
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
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.07),
                        child: Text(
                          title.toUpperCase(),
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.062,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff32324D),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.025),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: optionList
                              .map(
                                (option) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01),
                                  child: GestureDetector(
                                    onTap: (option
                                                .toLowerCase()
                                                .split(" ")[0] ==
                                            "explore")
                                        ? () => Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    ExploreExpertCounsellor(
                                                      title: option,
                                                    )),
                                              ),
                                            )
                                        : (option.toLowerCase().split(" ")[0] ==
                                                "connected")
                                            ? () => Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: ((context) =>
                                                        ConnectedCounsellor(
                                                          title: option,
                                                        )),
                                                  ),
                                                )
                                            : () {},
                                    child: professionalCounsellorCard(
                                      screenHeight,
                                      screenWidth,
                                      option,
                                      optionList.indexOf(option),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
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
