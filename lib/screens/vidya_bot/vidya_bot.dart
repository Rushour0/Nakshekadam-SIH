import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

import 'package:webview_flutter/webview_flutter.dart';

class VidyaBot extends StatefulWidget {
  const VidyaBot({Key? key}) : super(key: key);

  @override
  State<VidyaBot> createState() => _VidyaBotState();
}

class _VidyaBotState extends State<VidyaBot> {
  late WebViewController webViewController;
  String uid = getCurrentUserId();

  String link = "https://nakshekadam-vidya-bot.loca.lt";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vidya Bot",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "DM Sans",
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: COLOR_THEME['primary'],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: "$link/?uid=$uid",
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              allowsInlineMediaPlayback: true,
              onWebResourceError: (error) => print(error),
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) async {
                print(url);
              },
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
