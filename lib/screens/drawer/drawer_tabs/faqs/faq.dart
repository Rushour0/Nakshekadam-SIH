import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/drawer/drawer_tabs/faqs/components/faq_cards_search.dart';
import 'package:nakshekadam/screens/drawer/drawer_tabs/faqs/components/faq_controller.dart';
import 'package:provider/provider.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "FAQs",
          style: TextStyle(
              fontFamily: 'FigTree',
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.005, horizontal: screenWidth * 0.05),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.03),
                  child: SizedBox(
                    height: screenHeight * 0.83,
                    child: ChangeNotifierProvider<FAQsController>(
                      create: (_) => FAQsController(),
                      child: FAQsScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
