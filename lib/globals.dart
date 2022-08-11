import 'package:flutter/material.dart';

const String APP_TITLE = "NaksheKADAM";

// const String APP_ICON = "assets/images/app_icon.png";

const String DEFAULT_PROFILE_PICTURE =
    "https://i.ibb.co/FgnFSQc/default-profile-picture.jpg";

const bool IS_GRADIENT = true;

const Map<String, Color> COLOR_THEME = {
  "primary": Color(0xFF615793),
  "secondary": Color(0xFFDBD3FF),
  "tertiary": Color(0x7FFFB01D),
  "background": Color(0xFFFFFFFF),
  "buttonBackground": Color(0xFF615793),
  "textHeader": Color(0xFF32324D),
  "appBarText": Color(0xFFFFFFFF),
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
