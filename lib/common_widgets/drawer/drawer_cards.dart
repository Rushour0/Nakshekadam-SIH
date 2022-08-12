import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

class SmallSquareCard extends StatelessWidget {
  const SmallSquareCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
  }) : super(key: key);
  final String title, route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(
        screenWidth / 30,
      ),
      onTap: () async {
        // await deviceFCMKeyOperations();
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: screenWidth / 3.8,
        width: screenWidth / 3.8,
        decoration: BoxDecoration(
          color: COLOR_THEME['tertiary'],
          // gradient: !IS_GRADIENT
          //     ? LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           COLOR_THEME['tertiary'] as Color,
          //           COLOR_THEME['billCardBackground']!.withAlpha(0x9F),
          //         ],
          //       )
          //     : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5,
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.circular(
            screenWidth / 30,
          ),
        ),
        padding: EdgeInsets.all(screenWidth / 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              // color: Colors.white,
              size: screenWidth * 0.08,
            ),
            Text(
              title,
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontFamily: 'FigTree',
                color: Colors.black,
                fontSize: screenWidth * 0.034,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LargeRectangleCard extends StatelessWidget {
  const LargeRectangleCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
  }) : super(key: key);
  final String title, route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(
        screenWidth / 30,
      ),
      onTap: () async {
        if (route != "/login_signup_page") {
          print("meow meow");
          Navigator.pushNamed(context, route);
        } else {
          debugPrint("trying log out");
          await signOut();
          await signOutGoogle();
          Navigator.pushNamedAndRemoveUntil(context, route, (r) => false);
        }
      },
      child: Container(
        height: screenWidth / 5.7,
        width: screenWidth / 0.8,
        decoration: BoxDecoration(
          color: COLOR_THEME['tertiary'],
          // gradient: !IS_GRADIENT
          //     ? LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           COLOR_THEME['tertiary'] as Color,
          //           COLOR_THEME['formFieldColor']!.withAlpha(0x9F),
          //         ],
          //       )
          //     : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 2,
              // spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.circular(
            screenWidth / 30,
          ),
        ),
        padding: EdgeInsets.all(screenWidth / 60),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'FigTree',
              color: Colors.black,
              fontSize: screenWidth * 0.045,
            ),
          ),
          trailing: Icon(
            Icons.navigate_next_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ProfileSummaryCard extends StatelessWidget {
  ProfileSummaryCard({Key? key}) : super(key: key);
  final User? user = getCurrentUser();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // height: screenWidth / 4,
      width: screenWidth / 0.8,
      decoration: BoxDecoration(
        color: COLOR_THEME['primary'],
        gradient: IS_GRADIENT
            ? LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                // stops: [0.01, 0.1, 0.5, 0.9, 0.95],
                colors: [
                  COLOR_THEME['primary'] as Color,
                  COLOR_THEME['secondary'] as Color,
                  COLOR_THEME['tertiary'] as Color,
                  COLOR_THEME['secondary'] as Color,
                ],
              )
            : null,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(53, 245, 245, 245),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(
          screenWidth / 30,
        ),
      ),
      padding: EdgeInsets.all(screenWidth / 60),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 20,
          vertical: screenHeight / 50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.01),
                  child: Text(
                    user != null ? user!.displayName ?? "GUEST" : "GUEST",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FigTree',
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                ),
                Text(
                  user != null ? user!.email ?? "GUEST MAIL" : "GUEST MAIL",
                  style: TextStyle(
                    fontFamily: 'FigTree',
                    color: Colors.white,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ],
            ),
            Container(
              width: screenWidth / 8,
              height: screenWidth / 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    user != null
                        ? user!.photoURL ?? DEFAULT_PROFILE_PICTURE
                        : DEFAULT_PROFILE_PICTURE,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
