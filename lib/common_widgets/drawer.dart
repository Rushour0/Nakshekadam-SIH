import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  late String profileImageLink;
  List<List<String>> routesInfo = [
    ['Logout', '/login_signup_page'],
  ];
  late Map<String, dynamic> userInfo;

  @override
  void initState() {
    profileImageLink = "https://i.ibb.co/Ttp2tmY/20180419-175104.jpg";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const NetworkImage(DEFAULT_PROFILE_PICTURE), context);

    final num screenWidth = MediaQuery.of(context).size.width;
    final num screenHeight = MediaQuery.of(context).size.height;

    final User? user = getCurrentUser();
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.horizontal(left: Radius.elliptical(150, 500))),
      backgroundColor: COLOR_THEME['drawerBackground']!.withAlpha(0x9F),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight / 20, horizontal: screenWidth / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: screenWidth / 10,
                    backgroundImage: NetworkImage(user != null
                        ? user.photoURL != null
                            ? user.photoURL!
                            : DEFAULT_PROFILE_PICTURE
                        : DEFAULT_PROFILE_PICTURE),
                  ),
                  Text(
                    user != null
                        ? user.displayName != null
                            ? user.displayName as String
                            : "Guest"
                        : "Guest",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    user != null
                        ? user.email != null
                            ? user.email as String
                            : "Guest"
                        : "Guest",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(
              children: routesInfo.map(
                (List l) {
                  return Ink(
                    width: screenWidth * 0.67,
                    child: InkWell(
                      child: SizedBox(
                        width: screenWidth / 1,
                        height: screenHeight / 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            elevation: 5,
                            color: COLOR_THEME['secondary'],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.elliptical(
                                  400,
                                  900,
                                ),
                                right: Radius.elliptical(
                                  200,
                                  200,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  l[0],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'FigTree',
                                    color: COLOR_THEME['buttonText'],
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenHeight / 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (l[1] != '/login_signup_page') {
                          if (ModalRoute.of(context)!.settings.name != l[1]) {
                            Navigator.pushNamed(
                              context,
                              l[1],
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        } else {
                          await signOut();
                          await signOutGoogle();
                          if (!checkLoggedIn()) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              l[1],
                              (route) {
                                return false;
                              },
                            );
                          }
                        }
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
