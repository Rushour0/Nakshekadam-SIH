import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/models/college_extraction_model.dart';
import 'package:nakshekadam/screens/main/main_page.dart';
import 'package:nakshekadam/screens/main/tabs/college_page/college_page.dart';
import 'package:nakshekadam/screens/trees/components/tree_json_text.dart';
import 'package:nakshekadam/screens/trees/tree_from_json.dart';
import 'package:nakshekadam/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:nakshekadam/globals.dart';

class CareerOptionExpansionTiles extends StatelessWidget {
  const CareerOptionExpansionTiles({
    Key? key,
    required Map<String, dynamic> tilesData,
    required this.dataKey,
    required this.title,
    required this.optionCardName,
  })  : _tilesData = tilesData,
        super(key: key);
  final Map<String, dynamic> _tilesData;
  final String dataKey;
  final String title;
  final String optionCardName;

  @override
  Widget build(BuildContext context) {
    late WebViewController webViewController;
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
    return GestureDetector(
      onTap: (dataKey == "Explore all possible paths!" ||
              dataKey == "Detailed career paths")
          ? () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  TreeFromJson(jsonText: treeFromText[title.toLowerCase()]!)))
          : () {
              print(dataKey);
            },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        clipBehavior: Clip.antiAlias,
        child: (dataKey != "Explore all possible paths!" &&
                dataKey != "Detailed career paths")
            ? ExpansionTile(
                title: Text(
                  dataKey,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_down_sharp),
                backgroundColor: COLOR_THEME['careerTile'],
                collapsedBackgroundColor: COLOR_THEME['careerTile'],
                children: [
                  (_tilesData[dataKey] != "treeview")
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.01,
                          ),
                          color: COLOR_THEME['careerTileExpanded'],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_tilesData[dataKey]),
                              (dataKey == "Popular exams" ||
                                      dataKey == "Popular colleges" ||
                                      dataKey ==
                                          "Recommended colleges and exams")
                                  ? GestureDetector(
                                      onTap: () async {
                                        if (dataKey == "Popular exams") {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return Container(
                                                height: screenHeight * 0.5,
                                                width: screenWidth * 0.9,
                                                child: WebView(
                                                  initialUrl: stringData[
                                                          optionCardName][title]
                                                      ["Popular exams link"],
                                                  zoomEnabled: false,
                                                  javascriptMode: JavascriptMode
                                                      .unrestricted,
                                                  onPageStarted: (url) async {},
                                                  onWebViewCreated:
                                                      (controller) {
                                                    webViewController =
                                                        controller;
                                                  },
                                                ),
                                              );
                                            }),
                                          );
                                        } else if (dataKey ==
                                            "Popular colleges") {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) => MainPage(
                                                    tabIndex: 0,
                                                  )),
                                            ),
                                          );
                                        } else {
                                          CollegeExtractionModel
                                              collegeExtractionModel =
                                              CollegeExtractionModel.getModel();
                                          collegeExtractionModel
                                              .disciplineSearchController
                                              .text = title;
                                          await collegeExtractionModel
                                              .filterColleges();
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CollegePage()));
                                        }
                                      },
                                      child: Card(
                                        color: COLOR_THEME["bottomNavigation"],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              screenWidth * 0.03),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.01,
                                              horizontal: screenWidth * 0.05),
                                          child: Wrap(
                                            children: [
                                              Text(
                                                (dataKey == "Popular exams")
                                                    ? "All exams"
                                                    : "Explore Colleges",
                                                style: TextStyle(
                                                    fontFamily: "DM Sans",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              const Icon(
                                                Icons.open_in_browser_rounded,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container(),
                ],
              )
            : ListTile(
                tileColor: COLOR_THEME['careerTile'],
                title: Text(
                  dataKey,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
      ),
    );
  }
}
