import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_dialogbox_button.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/components/custom_text_form_field.dart';
import 'package:readmore/readmore.dart';

class ConnectedCounsellorCardConnected extends StatefulWidget {
  const ConnectedCounsellorCardConnected({Key? key}) : super(key: key);

  @override
  State<ConnectedCounsellorCardConnected> createState() =>
      _ConnectedCounsellorCardConnectedState();
}

class _ConnectedCounsellorCardConnectedState
    extends State<ConnectedCounsellorCardConnected> {
  TextEditingController _writeMessageController = TextEditingController();
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      color: COLOR_THEME["backgroundComponents2"],
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03, horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth / 7,
                  height: screenWidth / 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        DEFAULT_PROFILE_PICTURE,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Image.asset(
                //   // "$RESOURCE_CARD_IMAGES/${title.toLowerCase()}.png",
                //   ""
                //   width: screenWidth * 0.2,
                //   height: screenWidth * 0.2,
                //   fit: BoxFit.cover,
                // ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    child: Text(
                      "Dr. Name Sharma",
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        fontSize: screenHeight * 0.027,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            customTextField("Domain", "STEM", screenHeight, screenWidth),
            customTextField("Experiance", "n years", screenHeight, screenWidth),
            customTextField(
                "Specialization", "abcd feild", screenHeight, screenWidth),
            customTextField("University Name", "New York University",
                screenHeight, screenWidth),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
              ),
              child: Stack(
                children: [
                  mutliLineTestFormField(_writeMessageController,
                      "Write a Review", screenWidth, 3),
                  Positioned(
                    bottom: screenHeight * 0.045,
                    right: screenWidth * 0.02,
                    left: screenWidth * 0.02,
                    child: const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.003,
                    right: screenWidth * 0.25,
                    left: screenWidth * 0.25,
                    child: Card(
                      color: const Color(0xFFFFB01D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.006,
                            horizontal: screenWidth * 0.02),
                        child: Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: GestureDetector(
                onTap: () {},
                child: counsellorDialogBoxButton(
                    screenHeight, screenWidth, "Go to Chat"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
