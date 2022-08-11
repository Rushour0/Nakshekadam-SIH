import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/common_appbar.dart';
import 'package:nakshekadam/common_widgets/drawer.dart';
import 'package:nakshekadam/common_widgets/no_items.dart';
import 'package:nakshekadam/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var _bottomNavIndex = 0;
  late List<StatefulWidget> bodies;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      animationDuration: const Duration(seconds: 0),
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

    return Scaffold(
      key: scaffoldKey,
      endDrawer: CommonDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight / 10),
        child: CommonAppBar(
          scaffoldKey: scaffoldKey,
          title: SizedBox(
            // height: MediaQuery.of(context).size.height / 2,
            width: screenWidth / 5,
            child: Image.asset(
              APP_ICON,
              fit: BoxFit.contain,
            ),
          ),
          profilePicture: true,
        ),
      ),
      // backgroundColor: Colors.transparent,

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: COLOR_THEME['primary'],
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: COLOR_THEME['bottomNavigationSelected'],
        ), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          fixedColor: COLOR_THEME['bottomNavigationSelected'],
          currentIndex: _bottomNavIndex,
          backgroundColor: COLOR_THEME['primary'],
          elevation: 5,
          selectedLabelStyle: TextStyle(
            fontSize: screenWidth / 34,
            fontFamily: 'FigTree',
            color: COLOR_THEME['bottomNavigationSelected'],
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: screenWidth / 34,
            fontFamily: 'FigTree',
            color: COLOR_THEME['bottomNavigationUnselected'],
          ),
          items: [
            BottomNavigationBarItem(
              label: 'Colleges',
              activeIcon: ImageIcon(
                AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/bolt.png"),
                color: COLOR_THEME['bottomNavigationSelected'],
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 60),
                child: ImageIcon(
                  AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/bolt.png"),
                  color: COLOR_THEME['bottomNavigationUnselected'],
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Tests',
              activeIcon: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 60),
                child: ImageIcon(
                  AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/tests.png"),
                  color: COLOR_THEME['bottomNavigationSelected'],
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 60),
                child: ImageIcon(
                  AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/tests.png"),
                  color: COLOR_THEME['bottomNavigationUnselected'],
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              activeIcon: ImageIcon(
                AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/home.png"),
                color: COLOR_THEME['bottomNavigationSelected'],
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 60),
                child: ImageIcon(
                  AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/home.png"),
                  color: COLOR_THEME['bottomNavigationUnselected'],
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Genuine spares',
              activeIcon: ImageIcon(
                AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/explore.png"),
                color: COLOR_THEME['bottomNavigationSelected'],
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 60),
                child: ImageIcon(
                  AssetImage("$BOTTOM_NAVIGATION_IMAGE_DIRECTORY/explore.png"),
                  color: COLOR_THEME['bottomNavigationUnselected'],
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'My cart',
              activeIcon: Icon(
                Icons.shopping_cart_checkout_outlined,
                color: COLOR_THEME['bottomNavigationSelected'],
              ),
              icon: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight / 60),
                child: Icon(
                  Icons.shopping_cart_checkout_outlined,
                  color: COLOR_THEME['bottomNavigationUnselected'],
                ),
              ),
            )
          ],
          onTap: (index) => setState(
            () {
              _bottomNavIndex = index;
              _tabController.index = index;
            },
          ),
          //other params
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Put FIVE pages in the tab bar view
          NoItemsInTab(text: "NULL"),
          NoItemsInTab(text: "NULL"),
          NoItemsInTab(text: "NULL"),
          NoItemsInTab(text: "NULL"),
          NoItemsInTab(text: "NULL"),
        ],
      ),
    );
  }
}
