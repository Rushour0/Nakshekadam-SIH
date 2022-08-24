import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/walkthroughStudent.dart';
import 'package:nakshekadam/screens/walkthrough/walkthrough.dart';
import 'package:nakshekadam/services/Firebase/FireAuth/fireauth.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class StudentDetailsCollection extends StatefulWidget {
  const StudentDetailsCollection({Key? key}) : super(key: key);

  @override
  State<StudentDetailsCollection> createState() =>
      _StudentDetailsCollectionState();
}

class _StudentDetailsCollectionState extends State<StudentDetailsCollection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController marksController = TextEditingController();

  final List<String> classes = [
    "8th", "9th", "10th", "11th", "12th",
    // "Other"
  ];
  TextEditingController selectedClass = TextEditingController();

  final List<String> subjects = ["0", "1", "2", "3", "4", "5"];
  TextEditingController selectedSubjects = TextEditingController();
  List<TextEditingController> subjectsEditorList = [];

  final List<String> question = [
    "I am completely lost about what I am interested in as of now.",
    "Interested in a few subject combinations but not really sure about whether it's my calling.",
    "I am fairly sure about which subjects I want to take up but I have my doubts.",
    "Feeling pressured by friends or family? Feeling low?"
  ];
  TextEditingController selectedQuestion = TextEditingController();

  List<TextEditingController> interestDomainEditor = [];
  List<String> interestDomainList = [
    "STEM",
    "Commerce & Management",
    "Defense",
    "Civil Services",
    "Creative & Argumentative Studies",
    "Vocational Courses"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSubjects.addListener(() {
      int totalSubs = int.parse(selectedSubjects.text);
      if (subjectsEditorList.isEmpty) {
        for (int i = 0; i < totalSubs; i++) {
          subjectsEditorList.add(TextEditingController());
        }
      } else if (totalSubs > subjectsEditorList.length) {
        int diff = totalSubs - subjectsEditorList.length;
        for (int i = 0; i < diff; i++) {
          subjectsEditorList.add(TextEditingController());
        }
      } else if (totalSubs < subjectsEditorList.length) {
        int diff = subjectsEditorList.length - totalSubs;
        for (int i = 0; i < diff; i++) {
          subjectsEditorList.removeLast();
        }
      }
      setState(() {});
    });

    selectedQuestion.addListener(() {
      if (selectedQuestion.text == question[1] ||
          selectedQuestion.text == question[2]) {
        if (interestDomainEditor.isEmpty) {
          interestDomainEditor.add(TextEditingController());
        }
      } else {
        interestDomainEditor.clear();
      }
      setState(() {});
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
                (interestDomainEditor.isNotEmpty &&
                    interestDomainEditor[0].text == "") ||
                selectedClass.text == "" ||
                selectedSubjects.text == "") {
              return;
            }
            List<String> subjects = [];
            subjectsEditorList.forEach((subject) {
              if (subject.text == "") {
                return;
              }
              subjects.add(subject.text);
            });
            if (interestDomainEditor.isNotEmpty) {
              await userDocumentReference()
                  .collection("data")
                  .doc("userInfo")
                  .set({
                "school/college name": nameController.text,
                "class/grade": selectedClass.text,
                "marks/percentage": marksController.text,
                "number of subjects chosen": selectedSubjects.text,
                "subjects": subjects,
                "which of the following seems the best fit for you according to you?":
                    selectedQuestion.text,
                "interested domain": interestDomainEditor[0].text
              });
            } else {
              await userDocumentReference()
                  .collection("data")
                  .doc("userInfo")
                  .set({
                "school/college name": nameController.text,
                "class/grade": selectedClass.text,
                "marks/percentage": marksController.text,
                "number of subjects chosen": selectedSubjects.text,
                "subjects": subjects,
                "which of the following seems the best fit for you according to you?":
                    selectedQuestion.text,
              });
            }
            await userDocumentReference().update({
              "formFilled": true,
              "question": question.indexOf(selectedQuestion.text) + 1,
            });
            print("qq : ");

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WalkThroughStudent(),
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
                          "Help us with the last few details about your current academic status before you can begin unlocking our top-notch features!",
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
                                        child: CustomDropDownField(
                                          items: subjects,
                                          selectedItem: selectedSubjects,
                                          hintText:
                                              "Number of Subjects Chosen (0-5)",
                                        ),
                                      ),
                                      Column(
                                        children: subjectsEditorList
                                            .map(
                                              (editor) => Padding(
                                                padding: EdgeInsets.only(
                                                    top: screenHeight * 0.025),
                                                child: normalformfield(
                                                    editor,
                                                    screenWidth,
                                                    setState,
                                                    "Subject ${subjectsEditorList.indexOf(editor) + 1}",
                                                    TextInputType.name),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: screenHeight * 0.025,
                                        ),
                                        child: CustomDropDownFieldMultiLine(
                                          items: question,
                                          selectedItem: selectedQuestion,
                                          hintText:
                                              "Which of the following seems the best fit for you according to you?",
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.1),
                                        child: Column(
                                          children: interestDomainEditor
                                              .map(
                                                (editor) => Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          screenHeight * 0.025),
                                                  child: CustomDropDownField(
                                                    items: interestDomainList,
                                                    selectedItem: editor,
                                                    hintText:
                                                        "Interested Domain",
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
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
