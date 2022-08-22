import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakshekadam/screens/drawer/components/drawer_listtile.dart';
import 'package:nakshekadam/screens/drawer/components/drawer_user_info_card.dart';
import 'package:nakshekadam/screens/drawer/drawer_tabs/faqs/faq.dart';
import 'package:readmore/readmore.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_card_dialog.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/components/student_parent_card.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/student_details_collection.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/components/professional_counsellor_card.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/components/explore_counsellor_cards.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/components/explore_counsellor_sort.dart';

class SendFeedback extends StatefulWidget {
  const SendFeedback({
    Key? key,
  }) : super(key: key);

  @override
  State<SendFeedback> createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  TextEditingController _feedbackController = TextEditingController();
  double feedbackNumber = 10;

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
      extendBodyBehindAppBar: true,
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
            // await login();
          },
          child: Text(
            "CONTINUE",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenWidth * 0.06,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        // leading: const SizedBox.shrink(),
        toolbarHeight: screenHeight * 0.2,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: SizedBox(
          width: screenWidth,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  top: screenHeight * 0.04,
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.02),
              child: Text(
                "SHARE YOUR FEEDBACK",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff32324D),
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ]),
        ),
      ),
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
              height: screenHeight,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02),
                            child: Text(
                              "How Satistified are you with us?",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontSize: screenWidth * 0.05,
                                color: const Color(0xff32324D),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Card(
                            elevation: 3,
                            color: COLOR_THEME["backgroundComponents1"],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "$SEND_FEEDBACK_IMAGES/sad.png",
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.6,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: const Color(0xFF7551FF),
                                      inactiveTrackColor: Colors.grey,
                                      trackHeight: screenHeight * 0.01,
                                      activeTickMarkColor:
                                          const Color(0xFF7551FF),
                                      inactiveTickMarkColor: Colors.grey,
                                    ),
                                    child: Slider(
                                        value: feedbackNumber,
                                        min: 0,
                                        max: 10,
                                        divisions: 10,
                                        // activeColor: COLOR_THEME['secondary'],
                                        onChanged: (value) {
                                          setState(() {
                                            feedbackNumber = value;
                                            // _eyeSightLeft.text =
                                            //     (value < 0) ? value.toString() : "+$value";
                                          });
                                        }),
                                  ),
                                ),
                                Image.asset(
                                  "$SEND_FEEDBACK_IMAGES/happy.png",
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02),
                            child: Text(
                              "How Satistified are you with us?",
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                fontSize: screenWidth * 0.05,
                                color: const Color(0xff32324D),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Card(
                            elevation: 3,
                            color: COLOR_THEME["backgroundComponents2"],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.05),
                            ),
                            child: mutliLineTestFormField(
                                _feedbackController,
                                "Provide Your Feedback Here...",
                                screenWidth,
                                8),
                          )
                        ],
                      ),
                    ),
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
