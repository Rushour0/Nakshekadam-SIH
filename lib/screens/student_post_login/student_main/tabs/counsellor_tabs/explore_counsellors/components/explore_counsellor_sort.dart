import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/counsellor_page/components/counsellor_dialogbox_button.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/counsellor_tabs/professional_counsellor.dart';
import 'package:nakshekadam/strings.dart';

class ExploreCounsellorSort extends StatefulWidget {
  const ExploreCounsellorSort({
    Key? key,
    required this.domainData,
  }) : super(key: key);

  final Map<String, bool> domainData;

  @override
  State<ExploreCounsellorSort> createState() => _ExploreCounsellorSortState();
}

class _ExploreCounsellorSortState extends State<ExploreCounsellorSort> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      elevation: 2,
      backgroundColor: Colors.white,
      child: SizedBox(
        // height: screenHeight * 0.75,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.015,
            horizontal: screenWidth * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "DOMAIN",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "DM Sans",
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                ...widget.domainData.keys.map(
                  (domain) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(
                          COLOR_THEME["descriptionText"],
                        ),
                        value: widget.domainData[domain],
                        onChanged: (value) {
                          setState(() {
                            widget.domainData[domain] = value!;
                          });
                        },
                      ),
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: Text(
                          domain,
                          softWrap: true,
                          style: TextStyle(
                            color: COLOR_THEME["descriptionText"],
                            fontFamily: "DM Sans",
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      widget.domainData.forEach((key, value) {
                        if (value) {
                          widget.domainData[key] = false;
                          setState(() {});
                        }
                      });
                    },
                    child: Text(
                      "Clear all",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "DM Sans",
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
