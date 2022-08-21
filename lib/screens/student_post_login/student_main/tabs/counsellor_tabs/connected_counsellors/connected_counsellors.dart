import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_card_dialog.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/components/student_parent_card.dart';
import 'package:nakshekadam/screens/student_post_login/info_collection/student_details_collection.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/components/professional_counsellor_card.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/connected_counsellors/components/connected_counsellors_card_connected.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/connected_counsellors/components/connected_counsellors_card_pending.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/components/explore_counsellor_cards.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/components/explore_counsellor_sort.dart';

class ConnectedCounsellor extends StatefulWidget {
  const ConnectedCounsellor({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<ConnectedCounsellor> createState() => _ConnectedCounsellorState();
}

class _ConnectedCounsellorState extends State<ConnectedCounsellor> {
  TextEditingController _searchController = TextEditingController();

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
    TabBar _tabBar() => TabBar(
            indicatorWeight: 0.5,
            padding: EdgeInsets.zero,
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            // labelPadding: const EdgeInsets.only(left: 0, right: 10),
            indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(
                screenWidth * 0.02,
              ),
              color: const Color(0xffBBAFF0),
            ),
            tabs: [
              Container(
                width: screenWidth * 0.35,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Text(
                  "Pending",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff32324D),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.35,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Text(
                  "Connected",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff32324D),
                  ),
                ),
              ),
            ]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
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
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    top: screenHeight * 0.04,
                    bottom: screenHeight * 0.02,
                    left: screenWidth * 0.02),
                child: Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: screenWidth * 0.062,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff32324D),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              PreferredSize(
                preferredSize: _tabBar().preferredSize,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      screenWidth * 0.03,
                    ),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        screenWidth * 0.05,
                      ),
                      color: Colors.white,
                    ),
                    child: _tabBar(),
                  ),
                ),
              ),
              // SearchFormField(
              //     searchController: _searchController,
              //     hintText: "Search by name, company etc...",
              //     redirectFunction: redirectFunction),
            ]),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
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
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
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
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.05),
                                        child: ConnectedCounsellorCardPending(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.05),
                                        child: ConnectedCounsellorCardPending(),
                                      ),
                                    ],
                                  ),
                                ),

                                // Padding(
                                //   padding: EdgeInsets.only(top: screenHeight * 0.025),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //     children: optionList
                                //         .map(
                                //           (option) => Padding(
                                //             padding: EdgeInsets.symmetric(
                                //                 vertical: screenHeight * 0.01),
                                //             child: GestureDetector(
                                //               onTap: (option.toLowerCase() == "student")
                                //                   ? () => Navigator.of(context).push(
                                //                         MaterialPageRoute(
                                //                           builder: ((context) =>
                                //                               const StudentDetailsCollection()),
                                //                         ),
                                //                       )
                                //                   : () {},
                                //               child: professionalCounsellorCard(
                                //                 screenHeight,
                                //                 screenWidth,
                                //                 option,
                                //                 optionList.indexOf(option),
                                //               ),
                                //             ),
                                //           ),
                                //         )
                                //         .toList(),
                                //   ),
                                // ),
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
            Container(
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
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
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
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.05),
                                        child:
                                            ConnectedCounsellorCardConnected(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: screenHeight * 0.05),
                                        child:
                                            ConnectedCounsellorCardConnected(),
                                      ),
                                    ],
                                  ),
                                ),

                                // Padding(
                                //   padding: EdgeInsets.only(top: screenHeight * 0.025),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //     children: optionList
                                //         .map(
                                //           (option) => Padding(
                                //             padding: EdgeInsets.symmetric(
                                //                 vertical: screenHeight * 0.01),
                                //             child: GestureDetector(
                                //               onTap: (option.toLowerCase() == "student")
                                //                   ? () => Navigator.of(context).push(
                                //                         MaterialPageRoute(
                                //                           builder: ((context) =>
                                //                               const StudentDetailsCollection()),
                                //                         ),
                                //                       )
                                //                   : () {},
                                //               child: professionalCounsellorCard(
                                //                 screenHeight,
                                //                 screenWidth,
                                //                 option,
                                //                 optionList.indexOf(option),
                                //               ),
                                //             ),
                                //           ),
                                //         )
                                //         .toList(),
                                //   ),
                                // ),
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
          ],
        ),
      ),
    );
  }
}
