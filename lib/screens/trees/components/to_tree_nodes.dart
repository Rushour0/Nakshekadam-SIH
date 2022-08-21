import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:nakshekadam/screens/trees/components/decrease_font_weight.dart';
import 'package:nakshekadam/screens/trees/custom_tree_node.dart';
import 'package:webview_flutter/webview_flutter.dart';

List<TreeNode> toTreeNodes(
    dynamic parsedJson, FontWeight fontWeight, BuildContext context) {
  final List<double> tempDimensions = [
    MediaQuery.of(context).size.width,
    MediaQuery.of(context).size.height
  ];
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;
  if (parsedJson == null) {
    return [];
  }
  if (parsedJson is Map<String, dynamic>) {
    return parsedJson.keys.map(
      (k) {
        if (parsedJson[k].runtimeType != String &&
            parsedJson[k] != null &&
            parsedJson[k].keys.first == "link") {
          String link = parsedJson[k]["link"];
          parsedJson[k].remove("link");
          return TreeNode(
            content: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebView(
                      initialUrl: link,
                    ),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: "$k     ",
                  style: TextStyle(
                      fontFamily: "DM Sans",
                      fontSize: screenWidth * 0.04,
                      fontWeight: fontWeight,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Know More",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: "DM Sans",
                          fontSize: screenWidth * 0.04,
                          fontWeight: fontWeight,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            children: toTreeNodes(
                parsedJson[k], decreaseFontWeight(fontWeight), context),
          );
        } else {
          return TreeNode(
            content: Text(
              k,
              softWrap: true,
              style: TextStyle(
                fontFamily: "Cabin",
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w700,
              ),
            ),
            children: toTreeNodes(
                parsedJson[k], decreaseFontWeight(fontWeight), context),
          );
        }
      },
    ).toList();
  }
  if (parsedJson is List<dynamic>) {
    return parsedJson
        .asMap()
        .map(
          (i, element) => MapEntry(
            i,
            TreeNode(
              content: Text('[$i]:'),
              children:
                  toTreeNodes(element, decreaseFontWeight(fontWeight), context),
            ),
          ),
        )
        .values
        .toList();
  }
  return [
    TreeNode(
      content: Text(parsedJson.toString()),
    )
  ];
}
