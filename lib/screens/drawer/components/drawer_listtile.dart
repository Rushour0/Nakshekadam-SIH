import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';

ListTile drawerListTile(
    {required String title,
    required IconData icon,
    required Function() onTap,
    required double screenWidth,
    required int index}) {
  return ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        screenWidth * 0.02,
      ),
    ),
    trailing: Icon(
      size: screenWidth * 0.06,
      Icons.arrow_forward_ios_rounded,
      color: Colors.black,
    ),
    tileColor: COLOR_THEME["backgroundComponents${index % 4}"],
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "DM Sans",
        fontSize: screenWidth * 0.05,
        color: Colors.black,
      ),
    ),
    leading: Icon(
      size: screenWidth * 0.1,
      icon,
      color: Colors.black,
    ),
    onTap: onTap,
  );
}
