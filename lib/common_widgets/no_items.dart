import 'package:nakshekadam/globals.dart';
import 'package:flutter/material.dart';

class NoItemsInTab extends StatelessWidget {
  const NoItemsInTab({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
