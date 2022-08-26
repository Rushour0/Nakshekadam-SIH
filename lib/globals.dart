import 'package:flutter/material.dart';

const String APP_TITLE = "NaksheKADAM";

const String APP_ICON = "assets/images/app_icon.png";

const String DEFAULT_PROFILE_PICTURE =
    "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

const String BOTTOM_NAVIGATION_IMAGE_DIRECTORY =
    "assets/images/bottom_navigation_icons";

const String BANNER_IMAGE_DIRECTORY = "assets/images/banner_images";
const String STUDENT_BANNER_IMAGE_DIRECTORY =
    "assets/images/student_banner_images";

const String FEATURES_IMAGES_DIRECTORY = "assets/images/features_images";

const String BOTTOM_SHEETS_ILLUSTRATIONS_DIRECTORY =
    "assets/images/bottom_sheet_illustrations";

const String CAREER_OPTIONS_BOTTOM_SHEETS_ILLUSTRATIONS_DIRECTORY =
    "assets/images/career_options_bottom_sheet_illustrations";

const String CAREER_OPTIONS_BOTTOM_SHEET_ICON_DIRECTORY =
    "assets/images/bottom_sheet_illustrations/career_options_icons";

const String RESOURCE_CARD_IMAGES = "assets/images/resource_card_images";

const String COUNSELLOR_CARD_IMAGES = "assets/images/counsellor_card_images";

const String TESTS_CARD_IMAGES = "assets/images/tests_card_images";

const String POST_LOGIN_IMAGES = "assets/images/post_login_images";

const String PROFESSIONAL_COUNSELLOR_IMAGES =
    "assets/images/professional_counsellor_images";

const String SEND_FEEDBACK_IMAGES = "assets/images/send_feedback_images";
const String STUDENT_MAIN_OPTIONS = "assets/images/student_main_options";
const Map<String, dynamic> AGORA_CONFIG = {
  "appId": "3e7fb43c9b264f02892cf9a4177e4b80",
  "appCertificate": "46fa75d4381945ed8fb0cd08f9b37dae",
  'whiteboard': {
    'sdkTokenId':
        "NETLESSSDK_YWs9SDdTa3otbVpWem5yZmVudSZub25jZT1kY2ZlYjA2MC0xYmRiLTExZWQtYTg1Zi02ZGEwNzIxYmM3Mzgmcm9sZT0wJnNpZz04ZmZiYTEwNDQ1Y2NkODM2NGFlYTA3NTI4OTYwMzcwYTY1NTg2NzVjMTYxZDRmN2I1NTE4ZWJjMWM5YTgyMmZk"
  }
};

const bool IS_GRADIENT = true;

const Map<String, Color> COLOR_THEME = {
  // Main Colors
  "primary": Color(0xFF3E3763),
  "secondary": Color(0xFF615793),
  "tertiary": Color(0xFFDBD3FF),
  "backgroundComponents0": Color(0xFFFFDBA4),
  "backgroundComponents1": Color(0xFFFFB3B3),
  "backgroundComponents2": Color(0xFFC1EFFF),
  "backgroundComponents3": Color(0xFFD6CDFE),
  "background": Color(0xFFFFFFFF),

  // Home Page Colors

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
  "bottomNavigation": Color(0xFF615793),
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

  "careerTile": Color(0xFFFFC04C),
  "careerTileExpanded": Color(0xFFFAE2B6),

  "descriptionText": Color(0xFF615793),
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
