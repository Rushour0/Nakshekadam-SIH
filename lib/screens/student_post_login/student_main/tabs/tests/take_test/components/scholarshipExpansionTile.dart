import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/tests/take_test/components/domain_wise_percentage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScholarshipExpansionTile extends StatelessWidget {
  const ScholarshipExpansionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> scholarshipInfo = {
      "K.C.MAHINDRA Scholarship":
          "https://kcmet.org/what-we-do-Scholarship-Grants.aspx",
      "AICTE-Scholarship": "https://www.aicte-india.org/",
      "Sahu Jain Trust Inland Scholarship":
          "http://sahujaintrust.timesofindia.com/",
      "National Means Cum Merit Scholarship Scheme":
          "https://scholarships.gov.in/",
      "Commonwealth Shared Scholarships": "http://cscuk.dfid.gov.uk/apply/",
    };
    WebViewController webViewController;
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
          "Scholarship",
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
        children: scholarshipInfo.keys.map((scholarship) {
          return Column(
            children: [
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                ),
                child: Text(
                  scholarship,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "DM Sans",
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text("Scholarship"),
                      ),
                      body: WebView(
                        initialUrl: scholarshipInfo[scholarship],
                        zoomEnabled: false,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageStarted: (url) async {},
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                        },
                      ),
                    );
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: Card(
                    color: COLOR_THEME["primary"],
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Text(
                        "Know More",
                        style: TextStyle(
                          fontFamily: "DM Sans",
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
