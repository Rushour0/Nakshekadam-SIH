import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/trees/components/build_tree.dart';
import 'package:nakshekadam/screens/trees/components/tree_json_text.dart';
import 'package:nakshekadam/screens/trees/custom_tree_controller.dart';

class TreeFromJson extends StatefulWidget {
  const TreeFromJson({Key? key}) : super(key: key);

  @override
  _TreeFromJsonState createState() => _TreeFromJsonState();
}

class _TreeFromJsonState extends State<TreeFromJson> {
  final TreeController _treeController =
      TreeController(allNodesExpanded: false);
  final TextEditingController _textController =
      TextEditingController(text: treeTextJson);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: buildTree(_textController, _treeController, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
