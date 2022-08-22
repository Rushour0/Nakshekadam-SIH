import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/drawer/components/drawer_listtile.dart';
import 'package:nakshekadam/screens/drawer/components/drawer_user_info_card.dart';
import 'package:nakshekadam/screens/drawer/components/prelogin_info_card.dart';
import 'package:nakshekadam/screens/drawer/drawer_tabs/faqs/faq.dart';
import 'package:nakshekadam/screens/drawer/drawer_tabs/send_feedback/send_feedback.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';
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

class PreLoginCommonDrawer extends StatefulWidget {
  const PreLoginCommonDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<PreLoginCommonDrawer> createState() => _PreLoginCommonDrawerState();
}

class _PreLoginCommonDrawerState extends State<PreLoginCommonDrawer> {
  TextEditingController _searchController = TextEditingController();
  List<String> drawerTabs = [
    "FAQs",
    "Send Feedback",
    "Report Problems",
  ];

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
      appBar: AppBar(
        // leading: const SizedBox.shrink(),
        toolbarHeight: screenHeight * 0.4,
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
            const PreLoginDrawerUserInfoCard()
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
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02),
                            child: Column(
                              children: drawerTabs
                                  .map(
                                    (drawerOption) => Padding(
                                      padding: EdgeInsets.only(
                                          bottom: screenHeight * 0.015),
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05),
                                        ),
                                        child: drawerListTile(
                                          screenWidth: screenWidth,
                                          title: drawerOption,
                                          icon: (drawerOption == "FAQs")
                                              ? CupertinoIcons.question_square
                                              : (drawerOption ==
                                                      "Send Feedback")
                                                  ? Icons.feedback_outlined
                                                  : CupertinoIcons
                                                      .exclamationmark_octagon,
                                          onTap: (drawerOption == "FAQs")
                                              ? () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Faq()));
                                                }
                                              : (drawerOption ==
                                                      "Send Feedback")
                                                  ? () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const SendFeedback()));
                                                    }
                                                  : () {},
                                          index:
                                              drawerTabs.indexOf(drawerOption),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
