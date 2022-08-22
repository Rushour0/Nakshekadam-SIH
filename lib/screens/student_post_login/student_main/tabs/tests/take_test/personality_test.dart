// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
// import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
// import 'package:nakshekadam/common_widgets/customPageRouter.dart';
// import 'package:nakshekadam/common_widgets/formfields.dart';
// import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/reasoning_card.dart';
// import 'package:nakshekadam/screens/walkthrough/wtpages/wttwo.dart';
// import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
// import 'package:nakshekadam/globals.dart';
// import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

// class PersonalityTest extends StatefulWidget {
//   const PersonalityTest({Key? key}) : super(key: key);

//   @override
//   State<PersonalityTest> createState() => _PersonalityTestState();
// }

// class _PersonalityTestState extends State<PersonalityTest> {
//   @override
//   Widget build(BuildContext context) {
//     final List<double> tempDimensions = [
//       MediaQuery.of(context).size.width,
//       MediaQuery.of(context).size.height
//     ];
//     final double screenHeight = tempDimensions[0] > tempDimensions[1]
//         ? tempDimensions[0]
//         : tempDimensions[1];
//     final double screenWidth = tempDimensions[0] > tempDimensions[1]
//         ? tempDimensions[1]
//         : tempDimensions[0];
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       floatingActionButton: SizedBox(
//         width: screenWidth * 0.9,
//         height: screenHeight * 0.06,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: COLOR_THEME["primary"],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(screenHeight * 0.01),
//                 ),
//               ),
//               onPressed: () async {
//                 // await login();
//               },
//               child: Text(
//                 "PREVIOUS",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'Cabin',
//                   fontSize: screenWidth * 0.05,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: COLOR_THEME["primary"],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(screenHeight * 0.01),
//                 ),
//               ),
//               onPressed: () async {
//                 // await login();
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
//                 child: Text(
//                   "NEXT",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'Cabin',
//                     fontSize: screenWidth * 0.05,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: Container(
//         height: screenHeight,
//         width: screenWidth,
//         color: Colors.white,
//         child: Stack(
//           children: [
//             Positioned(
//               height: screenHeight,
//               width: screenWidth,
//               child: const BigOneSmallOneBG(),
//             ),
//             Positioned(
//               top: 0,
//               width: screenWidth,
//               bottom: 0,
//               child: SafeArea(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.04,
//                       vertical: screenHeight * 0.007),
//                   child: Column(
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "PERSONALITY TEST",
//                           style: TextStyle(
//                             fontFamily: "DM Sans",
//                             fontSize: screenWidth * 0.08,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xff32324D),
//                           ),
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: screenHeight * 0.05),
//                         child: Image.asset(
//                           "assets/images/aptitudeTestImage.png",
//                           width: screenWidth * 0.8,
//                           fit: BoxFit.fitWidth,
//                         ),
//                       ),
//                       NotificationListener<OverscrollIndicatorNotification>(
//                         onNotification: (overscroll) {
//                           overscroll.disallowIndicator();
//                           return true;
//                         },
//                         child: Expanded(
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [ReasoningCard()],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
