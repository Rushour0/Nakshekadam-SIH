import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/trees/custom_tree_controller.dart';
import 'package:nakshekadam/screens/trees/custom_tree_node.dart';

import 'custom_node_widget.dart';

Widget buildNodes(Iterable<TreeNode> nodes, double? indent,
    TreeController state, double? iconSize) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var node in nodes)
        NodeWidget(
          treeNode: node,
          indent: indent,
          state: state,
          iconSize: iconSize,
        )
    ],
  );
}