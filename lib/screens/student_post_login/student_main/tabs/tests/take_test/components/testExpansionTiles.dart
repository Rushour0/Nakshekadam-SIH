import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/domain_wise_percentage.dart';

class TestExpansionTile extends StatelessWidget {
  const TestExpansionTile({
    Key? key,
    required this.testName,
    required this.marksMap,
  }) : super(key: key);
  final String testName;
  final Map<String, double> marksMap;

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        collapsedBackgroundColor: COLOR_THEME["careerTile"],
        backgroundColor: COLOR_THEME["careerTile"],
        title: Text(
          testName,
          style: TextStyle(
            fontFamily: "DM Sans",
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        children: marksMap.keys.map((domain) {
          if (domain == "jobs as soon as possible") {
            return domainWisePercentage(
                screenHeight, screenWidth, "other fields", marksMap[domain]!);
          }
          return domainWisePercentage(screenHeight, screenWidth, domain,
              double.parse(marksMap[domain]!.toStringAsFixed(2)));
        }).toList(),
      ),
    );
  }
}
