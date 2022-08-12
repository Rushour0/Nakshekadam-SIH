import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/drawer/drawer_cards.dart';
import 'package:nakshekadam/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  late String profileImageLink;
  bool isAdmin = false;
  List<List<String>> routesInfo = [
    ['Logout', '/login_signup_page'],
  ];

  @override
  void initState() {
    profileImageLink = "https://i.ibb.co/Ttp2tmY/20180419-175104.jpg";
    super.initState();
    getIsAdmin().whenComplete(() => setState(() {}));
  }

  Future<void> getIsAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool('isAdmin')!;
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const NetworkImage(DEFAULT_PROFILE_PICTURE), context);

    final num screenWidth = MediaQuery.of(context).size.width;
    final num screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width, //20.0,
      child: Drawer(
        // shape: const RoundedRectangleBorder(
        //     borderRadius:
        //         BorderRadius.horizontal(left: Radius.elliptical(150, 500))),
        // backgroundColor: COLOR_THEME['drawerBackground']!.withAlpha(0x9F),
        backgroundColor: Colors.white,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(
            screenWidth / 20,
            screenHeight / 20,
            screenWidth / 20,
            0,
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 6.45),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.05,
                      // horizontal: screenWidth / 20,
                    ),
                    child: Wrap(
                        runSpacing: screenHeight / 50,
                        children: !isAdmin
                            ? [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    SmallSquareCard(
                                      title: "Settings",
                                      icon: Icons.settings_rounded,
                                      route: "/settings",
                                    ),
                                    SmallSquareCard(
                                      title: "Notifications",
                                      icon: Icons.notifications,
                                      route: "/notifications",
                                    ),
                                    SmallSquareCard(
                                      title: "Payments",
                                      icon: Icons.payments_rounded,
                                      route: "/payments",
                                    ),
                                  ],
                                ),
                                LargeRectangleCard(
                                  title: "Rewards",
                                  icon: Icons.star_border_rounded,
                                  route: "/rewards",
                                ),
                                LargeRectangleCard(
                                  title: "About",
                                  icon: Icons.info_rounded,
                                  route: "/about",
                                ),
                                LargeRectangleCard(
                                  title: "FAQs",
                                  icon: Icons.question_answer_outlined,
                                  route: "/faqs",
                                ),
                                LargeRectangleCard(
                                  title: "Send Feedback",
                                  icon: Icons.feedback_rounded,
                                  route: "/feedback",
                                ),
                                LargeRectangleCard(
                                  title: "Report a problem",
                                  icon: Icons.report,
                                  route: "/report",
                                ),
                                LargeRectangleCard(
                                  title: "Logout",
                                  icon: Icons.logout_rounded,
                                  route: "/login_signup_page",
                                ),
                              ]
                            : const [
                                LargeRectangleCard(
                                  title: "Logout",
                                  icon: Icons.logout_rounded,
                                  route: "/login_signup_page",
                                ),
                              ]),
                  ),
                ),
              ),
              Positioned(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    ProfileSummaryCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
