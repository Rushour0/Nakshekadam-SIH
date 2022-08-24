import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/walkthroughParent.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/walkthroughStudent.dart';
import 'package:nakshekadam/screens/walkthrough/walkthrough.dart';
import 'package:nakshekadam/services/Firebase/FireAuth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class ParentDetailsCollection extends StatefulWidget {
  const ParentDetailsCollection({Key? key}) : super(key: key);

  @override
  State<ParentDetailsCollection> createState() =>
      _ParentDetailsCollectionState();
}

class _ParentDetailsCollectionState extends State<ParentDetailsCollection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TextEditingController fathersOccupationController =
      TextEditingController();
  final TextEditingController mothersOccupationController =
      TextEditingController();
  final TextEditingController fathersEducationController =
      TextEditingController();
  final TextEditingController mothersEducationController =
      TextEditingController();
  final TextEditingController annualIncomeController = TextEditingController();

  final List<String> classes = [
    "8th", "9th", "10th", "11th", "12th",
    // "Other"
  ];
  TextEditingController selectedClass = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            if (nameController.text == "" ||
                marksController.text == "" ||
                fathersEducationController.text == "" ||
                mothersEducationController.text == "" ||
                fathersOccupationController.text == "" ||
                mothersOccupationController.text == "" ||
                annualIncomeController.text == "") {
              return;
            }
            await userDocumentReference()
                .collection("data")
                .doc("userInfo")
                .set({
              "school/college name": nameController.text,
              "class/grade": selectedClass.text,
              "father’s occupation": fathersOccupationController.text,
              "father’s education": fathersEducationController.text,
              "mother’s occupation": mothersOccupationController.text,
              "mother’s education": mothersEducationController.text,
              "Family’s annual income": annualIncomeController.text,
            });
            await userDocumentReference().update({
              "formFilled": true,
            });
            // print("qq : $a");

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WalkThroughParent(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "NEXT",
                style: TextStyle(
                  fontFamily: 'Cabin',
                  fontSize: screenWidth * 0.06,
                  color: const Color(0xffA5A5BA),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.28),
                child: Icon(
                  CupertinoIcons.arrow_right,
                  color: const Color(0xffA5A5BA),
                  size: screenWidth * 0.07,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
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
              bottom: 0,
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
                      Image.asset(
                        'assets/images/post_login_images/studentPLInfoCollect.png',
                        width: screenWidth * 0.7,
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.05),
                        child: Text(
                          "Help us with the last few details about your child’s current academic status before you can begin unlocking our top-notch features!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
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
                            child: Column(
                              children: [
                                Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.02),
                                        child: normalformfield(
                                            nameController,
                                            screenWidth,
                                            setState,
                                            "School / College Name",
                                            TextInputType.name),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.025),
                                              child: CustomDropDownField(
                                                items: classes,
                                                selectedItem: selectedClass,
                                                hintText: "Class / Grade",
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 5,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: screenWidth * 0.05,
                                                  top: screenHeight * 0.025),
                                              child: normalformfield(
                                                  marksController,
                                                  screenWidth,
                                                  setState,
                                                  "Marks / Percentage",
                                                  TextInputType.text),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.025),
                                        child: normalformfield(
                                            fathersOccupationController,
                                            screenWidth,
                                            setState,
                                            "Father’s Occupation",
                                            TextInputType.name),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeight * 0.025,
                                        ),
                                        child: normalformfield(
                                            mothersOccupationController,
                                            screenWidth,
                                            setState,
                                            "Mother’s Occupation",
                                            TextInputType.name),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.025),
                                        child: normalformfield(
                                            fathersEducationController,
                                            screenWidth,
                                            setState,
                                            "Father’s Education (Eg. MBA, B.Tech)",
                                            TextInputType.name),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeight * 0.025,
                                        ),
                                        child: normalformfield(
                                            mothersEducationController,
                                            screenWidth,
                                            setState,
                                            "Mother’s Education (Eg. MBA, B.Tech)",
                                            TextInputType.name),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.1,
                                            top: screenHeight * 0.025),
                                        child: normalformfield(
                                            annualIncomeController,
                                            screenWidth,
                                            setState,
                                            "Family’s annual income",
                                            TextInputType.number),
                                      ),
                                    ],
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
          ],
        ),
      ),
    );
  }
}
