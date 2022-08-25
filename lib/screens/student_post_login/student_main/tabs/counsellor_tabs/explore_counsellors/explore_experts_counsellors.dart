import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/classes/explore_person.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/components/explore_counsellor_cards.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/explore_counsellors/components/explore_counsellor_sort.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';

class ExploreExpertCounsellor extends StatefulWidget {
  const ExploreExpertCounsellor({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<ExploreExpertCounsellor> createState() =>
      _ExploreExpertCounsellorState();
}

class _ExploreExpertCounsellorState extends State<ExploreExpertCounsellor> {
  TextEditingController _searchController = TextEditingController();
  Map<String, bool> domainData = {
    "STEM": false,
    "Commere and management": false,
    "Defense": false,
    "Civil services": false,
    "Creative and argumentative studies": false,
    "Vocational courses ": false,
  };

  @override
  Widget build(BuildContext context) {
    void redirectFunction() {
      Navigator.of(context).push(
        PageRouteBuilder(
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          opaque: false,
          transitionDuration: const Duration(milliseconds: 750),
          pageBuilder: (_, __, ___) => ExploreCounsellorSort(
            domainData: domainData,
          ),
        ),
      );
    }

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
            SearchFormField(
                searchController: _searchController,
                hintText: "Search by name, company etc...",
                redirectFunction: redirectFunction),
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
                            child: StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: firestore
                                  .collection('explore_data')
                                  .doc(widget.title
                                      .split(' ')[1]
                                      .substring(0,
                                          widget.title.split(' ')[1].length - 1)
                                      .toLowerCase())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    try {
                                      Map<String, dynamic> docData =
                                          snapshot.data!.data()!;

                                      return Column(
                                        children: docData.keys.map((uid) {
                                          Map<String, dynamic> rawData =
                                              docData[uid];

                                          rawData.putIfAbsent('uid', () => uid);
                                          final ExplorePerson data =
                                              ExplorePerson.fromJson(
                                            rawData,
                                          );
                                          print(data);
                                          return ExploreCounsellorCard(
                                            data: data,
                                          );
                                        }).toList(),
                                      );
                                    } catch (e) {
                                      print(e);
                                      return Center(
                                        child: Text(
                                          "No data found",
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: screenWidth * 0.05),
                                        ),
                                      );
                                    }
                                  }
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: COLOR_THEME['primary']),
                                );
                              },
                            ),
                            //  Column(
                            //   children: [
                            //     Padding(
                            //       padding: EdgeInsets.only(
                            //           bottom: screenHeight * 0.05),
                            //       child: ExploreCounsellorCard(),
                            //     ),
                            //     Padding(
                            //       padding: EdgeInsets.only(
                            //           bottom: screenHeight * 0.05),
                            //       child: ExploreCounsellorCard(),
                            //     ),
                            //   ],
                            // ),
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
    );
  }
}
