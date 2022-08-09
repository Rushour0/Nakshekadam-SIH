import 'package:flutter/material.dart';

const String APP_TITLE = "NaksheKADAM";

// const String APP_ICON = "assets/images/app_icon.png";

const String DEFAULT_PROFILE_PICTURE =
    "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

const bool IS_GRADIENT = true;

const Map<String, Color> COLOR_THEME = {
  "primary": Color(0xFF7DD076),
  "secondary": Color(0xFF26ABFF),
  "tertiary": Color(0xFFB4E197),
  "background": Color(0xFFFFFFFF),
  "extraButtonColor": Color(0xFFF4CB4A),
  "formFieldColor": Color(0xFFF4CB81),
  "plusMinusBar": Color(0xFFF4CB81),
  "searchFieldBackground": Color(0xFFF4CB81),
  "searchFieldText": Colors.black,
  "drawerBackground": Color(0xFF59BFFF),
  "billCardBackground": Color(0xFF59BFFF),
  "slideToConfirmEnd": Color(0xFFF4CB4A),
  "loginSignUpButtonText": Colors.white,
  "formFieldText": Colors.black,
  "formFieldHintText": Colors.white,
  "formFieldShadowColor": Color(0xFFF4CB81),
  "formFieldIconColor": Colors.white,
  "buttonText": Colors.white,
  "tabSelectColor": Colors.black,
};

//
// const Map<String, Color> COLOR_THEME = {
//   "extraButtonColor": Color.fromARGB(255, 244, 203, 72),
//   "background": Color(0xFFE9EFC0),
//   "formFieldColor": Color(0xFFFEF5ED),
//   "tertiary": Color(0xFFB4E197),
//   "secondary": Color(0xFF83BD75),
//   "primary": Color(0xFF4E944F)
// };

const String RAZORPAY_KEY = "rzp_live_80XyMCx6NSm4UA";

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