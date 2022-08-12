import 'package:flutter/material.dart';

const String APP_TITLE = "NaksheKADAM";

const String APP_ICON = "assets/images/app_icon.png";

const String DEFAULT_PROFILE_PICTURE =
    "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

String BOTTOM_NAVIGATION_IMAGE_DIRECTORY =
    "assets/images/bottom_navigation_icons";

const bool IS_GRADIENT = true;

const Map<String, Color> COLOR_THEME = {
  // Main Colors
  "primary": Color(0xFF3E3763),
  "secondary": Color(0xFF615793),
  "tertiary": Color(0xFFDBD3FF),
  "backgroundComponents": Color(0x7FFFB01D),
  "background": Color(0xFFFFFFFF),

  // "primary": Color(0xFF42C2FF),
  // "secondary": Color(0xFF111D5E),
  // "tertiary": Color(0xFF00EAD3),
  // "backgroundComponents": Color(0x7FFFB01D),
  // "background": Color(0xFFFFFFFF),

  // AppBar Colors
  "appBarText": Color(0xFFFFFFFF),

  // Field Colors
  "searchFieldText": Colors.black,
  "searchFieldBackground": Color(0xFFF4CB81),
  "formFieldText": Colors.black,
  "formFieldHintText": Colors.white,
  "formFieldShadowColor": Color(0xFFF4CB81),
  "formFieldIconColor": Colors.white,

  // Drop down colors
  "languageDropDownBackground": Colors.white,
  "languageDropDownText": Colors.black,

  // Bottom Navigation Bar Colors
  "bottomNavigation": Color(0xFF111D5E),
  "bottomNavigationSelected": Color(0xFFFFB01D),
  "bottomNavigationUnselected": Color(0xFFFFFFFF),

  "buttonBackground": Color(0xFF615793),
  "textHeader": Color(0xFF32324D),
  "plusMinusBar": Color(0xFFF4CB81),
  "drawerBackground": Color(0xFF59BFFF),
  "billCardBackground": Color(0xFF59BFFF),
  "slideToConfirmEnd": Color(0xFFF4CB4A),
  "loginSignUpButtonText": Colors.white,
  "buttonText": Colors.white,

  'optionButtonText': Color(0xFF8E8EA9),
};

// const String RAZORPAY_KEY = "rzp_live_80XyMCx6NSm4UA";

final DEFAULT_TEXT_THEME = TextTheme(
  bodyText1: const TextStyle(
    fontFamily: 'FigTree',
    fontSize: 18,
    color: Colors.white,
  ),
  headline1: TextStyle(
    fontFamily: 'FigTree',
    fontSize: 60,
    color: COLOR_THEME['secondary'],
  ),
  headline2: TextStyle(
    fontFamily: 'FigTree',
    fontSize: 60,
    color: COLOR_THEME['primary'],
  ),
  headline3: const TextStyle(
    fontFamily: 'FigTree',
    fontSize: 28,
    color: Colors.black,
  ),
  subtitle1: const TextStyle(
    fontFamily: 'FigTree',
    fontSize: 20,
    color: Colors.grey,
  ),
  subtitle2: const TextStyle(
    fontFamily: 'FigTree',
    fontSize: 26,
    color: Colors.grey,
  ),
  button: const TextStyle(
    fontFamily: 'FigTree',
    fontSize: 20,
    color: Colors.grey,
  ),
);
