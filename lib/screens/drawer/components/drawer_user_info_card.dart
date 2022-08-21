import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/drawer/components/drawer_card_field.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_dialogbox_button.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/components/custom_text_form_field.dart';
import 'package:readmore/readmore.dart';

class DrawerUserInfoCard extends StatefulWidget {
  const DrawerUserInfoCard({Key? key}) : super(key: key);

  @override
  State<DrawerUserInfoCard> createState() => _DrawerUserInfoCardState();
}

class _DrawerUserInfoCardState extends State<DrawerUserInfoCard> {
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
      color: const Color(0xFF3E3763),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                "ERA AGGARWAL",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: Text(
                "Student",
                softWrap: true,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenHeight * 0.025,
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            drawerCardField(
                "E-mail ID", "era78@gmail.com", screenHeight, screenWidth),
            drawerCardField("School Name", "abcxyz", screenHeight, screenWidth),
            drawerCardField("Grade", "11th", screenHeight, screenWidth),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 3,
                    color: const Color(0xFFF94141),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.015),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.006,
                          horizontal: screenWidth * 0.1),
                      child: Text(
                        "Logout",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "DM Sans",
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
