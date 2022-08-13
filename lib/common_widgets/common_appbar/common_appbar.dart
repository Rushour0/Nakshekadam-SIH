import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/classes/language.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

AppBar commonAppBar({
  required Widget title,
  required GlobalKey<ScaffoldState> scaffoldKey,
  bool profilePicture = true,
  required double screenWidth,
  required double screenHeight,
}) {
  Language language = Language();

  User? user = getCurrentUser();
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(screenWidth / 20),
        bottomLeft: Radius.circular(screenWidth / 20),
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(
          right: screenWidth / 20,
        ),
        child: GestureDetector(
          onTap: () async {
            scaffoldKey.currentState!.openEndDrawer();
          },
          child: profilePicture
              ? Container(
                  width: screenWidth / 10,
                  height: screenWidth / 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        user != null
                            ? user.photoURL ?? DEFAULT_PROFILE_PICTURE
                            : DEFAULT_PROFILE_PICTURE,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : Container(),
        ),
      ),
    ],
    title: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 40,
        vertical: screenHeight / 20,
      ),
      child: title,
      //  Text(
      //   title,
      //   style: TextStyle(
      //     fontFamily: 'FigTree',
      //     color: COLOR_THEME['primary'],
      //     fontWeight: FontWeight.bold,
      //     fontSize: screenWidth / 15,
      //   ),
      // ),
    ),
    toolbarHeight: screenHeight / 10,
    backgroundColor: COLOR_THEME['primary'],
    elevation: 3,
  );
}
