import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/trees/components/to_tree_nodes.dart';
import 'package:nakshekadam/screens/trees/custom_tree_controller.dart';
import 'package:nakshekadam/screens/trees/custom_tree_view.dart';

/// Builds tree or error message out of the entered content.
Widget buildTree(TextEditingController _textController,
    TreeController _treeController, BuildContext context) {
  try {
    var parsedJson = json.decode(_textController.text);
    return TreeView(
      nodes: toTreeNodes(parsedJson, FontWeight.w900, context),
      treeController: _treeController,
    );
  } on FormatException catch (e) {
    return Text(e.message);
  }
}
