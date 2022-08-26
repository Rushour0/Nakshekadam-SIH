import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/info_card.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/option_buttons.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  List<String> infoCardNames = [
    'Our Vision',
    'About DoESL',
    "New Education Policy' 20 - Transforming India",
  ];
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.15),
            child: Column(
              children: infoCardNames.map((name) {
                int index = infoCardNames.indexOf(name);
                return Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: infoCard(screenWidth, screenHeight, name, index),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
