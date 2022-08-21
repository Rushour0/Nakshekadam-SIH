import 'package:flutter/material.dart';

FontWeight decreaseFontWeight(FontWeight fontWeight) {
  if (fontWeight == FontWeight.w900) {
    return FontWeight.w800;
  } else if (fontWeight == FontWeight.w800) {
    return FontWeight.w700;
  } else if (fontWeight == FontWeight.w700) {
    return FontWeight.w600;
  } else if (fontWeight == FontWeight.w600) {
    return FontWeight.w500;
  } else if (fontWeight == FontWeight.w500) {
    return FontWeight.w400;
  } else if (fontWeight == FontWeight.w400) {
    return FontWeight.w300;
  } else if (fontWeight == FontWeight.w300) {
    return FontWeight.w200;
  }
  return FontWeight.w100;
}
