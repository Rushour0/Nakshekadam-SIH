import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/models/circular_chart_model.dart';

class CircularChart extends StatelessWidget {
  const CircularChart({
    Key? key,
    required this.percentage,
    required this.domain,
  }) : super(key: key);
  final double percentage;
  final String domain;

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
    final List<ChartData> chartData = [
      ChartData("marks", percentage, color: COLOR_THEME["secondary"]!),
      ChartData("empty", 1 - percentage, color: Colors.grey),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Highest Score",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                        Text(
                          "Domain suggested: $domain",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${percentage * 100}%",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "DM Sans",
                      fontSize: screenWidth * 0.04,
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  SfCircularChart(
                    series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                          dataSource: chartData,
                          radius: "${screenWidth * 0.35}",
                          innerRadius: "${screenWidth * 0.23}",
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.155),
                    child: Center(
                      child: Text(
                        "${percentage * 100}%",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM Sans",
                          fontSize: screenWidth * 0.07,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.195),
                    child: Center(
                      child: Text(
                        "SCORE",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "DM Sans",
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
