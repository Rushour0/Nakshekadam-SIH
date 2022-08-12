import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/bigOneSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/bigTwoSmallOneBg.dart';
import 'package:nakshekadam/common_widgets/common_appbar/common_appbar.dart';
import 'package:nakshekadam/common_widgets/common_appbar/components/language_dropdown.dart';
import 'package:nakshekadam/common_widgets/drawer/drawer.dart';
import 'package:nakshekadam/common_widgets/no_items.dart';
import 'package:nakshekadam/globals.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var _bottomNavIndex = 2;
  late List<StatefulWidget> bodies;
  late TabController _tabController;

  List<String> tabNames = [
    'Colleges',
    'Tests',
    'Home',
    'Counsellors',
    'Explore',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      animationDuration: const Duration(milliseconds: 0),
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
    _tabController.addListener(
      () {
        ;
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          // screenHeight * 0.01,
          // screenHeight * 0.01,
          // screenHeight * 0.01,
          screenWidth * 0.04,
          0,
          screenWidth * 0.04,

          screenHeight * 0.01,
        ),
        child: CustomNavigationBar(
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
      ),

      body: Stack(
        children: [
          const BigOneSmallOneBG(),
          Positioned(
            top: screenHeight / 10,
            left: 0,
            width: screenWidth,
            height: screenHeight,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                // Put FIVE pages in the tab bar view

                NoItemsInTab(text: "0"),
                NoItemsInTab(text: "1"),
                NoItemsInTab(text: "2"),
                NoItemsInTab(text: "3"),
                NoItemsInTab(text: "4"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
