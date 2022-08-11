import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

class CommonAppBar extends StatelessWidget {
  CommonAppBar({
    Key? key,
    required this.title,
    required this.scaffoldKey,
    this.profilePicture = true,
  }) : super(key: key);

  final Widget title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool profilePicture;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    User? user = getCurrentUser();
    return AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(
            right: screenWidth / 20,
          ),
          child: GestureDetector(
            onTap: () async {
              // scaffoldKey.currentState!.openEndDrawer();
            },
            child: profilePicture
                ? CircleAvatar(
                    radius: screenWidth / 15,
                    backgroundImage: NetworkImage(
                      user != null
                          ? user.photoURL ?? DEFAULT_PROFILE_PICTURE
                          : DEFAULT_PROFILE_PICTURE,
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
      elevation: 0,
    );
  }
}
