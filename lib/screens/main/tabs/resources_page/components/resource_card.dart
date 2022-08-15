import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/bottom_sheet.dart';
import 'package:nakshekadam/screens/main/tabs/resources_page/components/resource_explore_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:nakshekadam/strings.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          screenHeight * 0.02,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "$RESOURCE_CARD_IMAGES/${title.toLowerCase()}.png",
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenHeight * 0.023,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.01),
                          child: Text(
                            stringData["resources"][title.toLowerCase()]
                                ["subHeading"],
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontSize: screenHeight * 0.02,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF8696BB),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.02, bottom: screenHeight * 0.02),
              child: Text(
                stringData["resources"][title.toLowerCase()]["description"],
                style: TextStyle(
                  fontFamily: "DM Sans",
                  fontSize: screenHeight * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: COLOR_THEME['secondary'],
                        centerTitle: true,
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: WebView(
                              initialUrl: stringData["resources"]
                                  [title.toLowerCase()]["link"],
                              zoomEnabled: false,
                              javascriptMode: JavascriptMode.unrestricted,
                              onPageStarted: (url) async {},
                              onWebViewCreated: (controller) {
                                webViewController = controller;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              },
              child: resourceExploreButton(screenHeight, screenWidth),
            ),
          ],
        ),
      ),
    );
  }
}
