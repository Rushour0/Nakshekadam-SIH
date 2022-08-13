import 'package:flutter/material.dart';

Container careerOptionsCard({
  required Icon icon,
  required String title,
  required String summary,
  required double side,
}) {
  TextStyle titleStyle = TextStyle(
    color: Colors.black,
    fontFamily: "DM Sans",
    fontSize: side * 0.5,
    fontWeight: FontWeight.bold,
  );

  TextStyle summaryStyle = TextStyle(
    color: Colors.black,
    fontFamily: "DM Sans",
    fontSize: side * 0.3,
  );
  return Container(
    height: side,
    width: side,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: side * 0.05,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Text(
          title,
          style: titleStyle,
        ),
        Text(
          summary,
          style: summaryStyle,
        )
      ],
    ),
  );
}
