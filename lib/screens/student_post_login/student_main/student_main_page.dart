import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/common_appbar/common_appbar.dart';
import 'package:nakshekadam/common_widgets/common_appbar/components/language_dropdown.dart';
import 'package:nakshekadam/common_widgets/drawer/drawer.dart';
import 'package:nakshekadam/common_widgets/no_items.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/user_details_model.dart';
import 'package:nakshekadam/screens/main/tabs/college_page/college_page.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/counsellor_page.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/home_page.dart';
import 'package:nakshekadam/screens/main/tabs/resources_page/resources_page.dart';
import 'package:nakshekadam/screens/main/tabs/tests_page.dart/test_page.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/home_page/student_home_page.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/student_tests.dart';
import 'package:nakshekadam/services/Firebase/firestore/firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({Key? key}) : super(key: key);

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var _bottomNavIndex = 2;
  late List<StatefulWidget> bodies;
  late TabController _tabController;
  // UserDetailsModelOne userDetailsModelOne = UserDetailsModelOne.getModel();
  // UserDetailsModelTwo userDetailsModelTwo = UserDetailsModelTwo.getModel();

  List<String> tabNames = [
    'Notifications',
    'Tests',
    'Home',
    'Counsellors',
    'More',
  ];

  @override
  void initState() {
    super.initState();
    userDocumentReference().get().then((value) {
      UserDetailsModelOne.fromMap(value.data()!);
      setState(() {
        // print("usermodel : $userDetailsModelOne");
      });
    });
    userDocumentReference()
        .collection("data")
        .doc("userInfo")
        .get()
        .then((value) {
      UserDetailsModelTwo.fromMap(value.data()!);
      setState(() {
        // print("usermodeltwo : $userDetailsModelTwo");
      });
    });
    _tabController = TabController(
      animationDuration: const Duration(milliseconds: 0),
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
    _tabController.addListener(
      () {
        if (_tabController.previousIndex != _tabController.index) {
          print(_tabController.index);
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

    WebViewController webViewController;

    TextStyle navigationStyle = TextStyle(
      fontFamily: "DM Sans",
      color: Colors.white,
      fontSize: screenWidth * 0.03,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      key: scaffoldKey,
      endDrawer: CommonDrawer(),
      appBar: commonAppBar(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        scaffoldKey: scaffoldKey,
        title: LanguageDropDown(
          parentSet: setState,
        ),
        // Text(
        //   'NaksheKADAM',
        //   style: TextStyle(
        //     fontFamily: 'DM Sans',
        //     fontSize: screenWidth * 0.05,
        //     fontWeight: FontWeight.bold,
        //     color: COLOR_THEME['appBarText'],
        //   ),
        // ),
        profilePicture: true,
      ),

      // backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(
          // screenHeight * 0.01,
          // screenHeight * 0.01,
          // screenHeight * 0.01,
          screenWidth * 0.04,
          0,
          screenWidth * 0.04,

          screenHeight * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.01),
              child: _bottomNavIndex != 3
                  ? FloatingActionButton(
                      backgroundColor: COLOR_THEME['floatingActionButton'],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text(
                                  "Vidya Bot",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "DM Sans",
                                    fontSize: screenWidth * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: COLOR_THEME['secondary'],
                                centerTitle: true,
                              ),
                              body: Column(
                                children: [
                                  Expanded(
                                    child: WebView(
                                      initialUrl:
                                          "https://nakshekadam-chatbot.netlify.app/",
                                      zoomEnabled: false,
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      onPageStarted: (url) async {},
                                      onWebViewCreated: (controller) {
                                        webViewController = controller;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                      child: Icon(
                        Icons.chat,
                      ),
                    )
                  : FloatingActionButton.extended(
                      label: Text(
                        "Chat with our AI Counsellors",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontFamily: "DM Sans",
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: COLOR_THEME['floatingActionButton'],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text(
                                  "Vidya Bot",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "DM Sans",
                                    fontSize: screenWidth * 0.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: COLOR_THEME['secondary'],
                                centerTitle: true,
                              ),
                              body: Column(
                                children: [
                                  Expanded(
                                    child: WebView(
                                      initialUrl:
                                          "https://nakshekadam-chatbot.netlify.app/",
                                      zoomEnabled: false,
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      onPageStarted: (url) async {},
                                      onWebViewCreated: (controller) {
                                        webViewController = controller;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                      icon: Icon(
                        Icons.chat,
                      ),
                    ),
            ),
            CustomNavigationBar(
              selectedColor: COLOR_THEME['bottomNavigationSelected'],
              currentIndex: _bottomNavIndex,
              backgroundColor: COLOR_THEME['bottomNavigation']!,
              elevation: 0,
              borderRadius: Radius.circular(screenWidth / 20),
              // isFloating: true,
              // selectedtitleStyle: TextStyle(
              //   fontSize: screenWidth / 34,
              //   fontFamily: 'DM Sans',
              //   color: COLOR_THEME['bottomNavigationSelected'],
              // ),
              // unselectedtitleStyle: TextStyle(
              //   fontSize: screenWidth / 34,
              //   fontFamily: 'DM Sans',
              //   color: COLOR_THEME['bottomNavigationUnselected'],
              // ),
              items: tabNames
                  .map(
                    (tabName) => CustomNavigationBarItem(
                      selectedTitle: Text(
                        tabName,
                        style: navigationStyle,
                      ),
                      title: Container(),
                      selectedIcon: ImageIcon(
                        // size: screenWidth * 0.09,
                        AssetImage(
                            "$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/${tabName.toLowerCase()}.png"),
                        color: COLOR_THEME['bottomNavigationSelected'],
                      ),
                      icon: ImageIcon(
                        AssetImage(
                            "$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/${tabName.toLowerCase()}.png"),
                        color: COLOR_THEME['bottomNavigationUnselected'],
                      ),
                    ),
                  )
                  .toList(),
              onTap: (index) => setState(
                () {
                  _bottomNavIndex = index;
                  _tabController.index = index;
                },
              ),
              //other params
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          const BigOneSmallOneBG(),
          Positioned(
            top: screenHeight / 7,
            left: 0,
            width: tempDimensions[0] > tempDimensions[1]
                ? tempDimensions[1]
                : tempDimensions[0],
            height: tempDimensions[0] > tempDimensions[1]
                ? tempDimensions[0]
                : tempDimensions[1] * 0.9,
            child: TabBarView(
              // viewportFraction: 0.9,
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                // Put FIVE pages in the tab bar view

                // NoItemsInTab(text: "0"),
                NoItemsInTab(text: "0"),
                StudentTestsPage(),
                StudentHomePage(),
                CounsellorPage(),
                NoItemsInTab(text: "4"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
