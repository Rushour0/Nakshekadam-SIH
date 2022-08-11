import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nakshekadam/services/AadharOTP/otp/auth/otp_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AadharLoginPage extends StatefulWidget {
  const AadharLoginPage({Key? key}) : super(key: key);

  @override
  State<AadharLoginPage> createState() => _AadharLoginPageState();
}

class _AadharLoginPageState extends State<AadharLoginPage> {
  late WebViewController webViewController;
  late Image image;
  bool isWebViewOn = false;
  bool imageReady = false;
  bool isLoading = false;
  bool gettingAadhar = false;
  bool firstLink = true;

  String requestID = "", link = "", aadhaar = "", otp = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    String aadhaar_number = "483320406191";
    // String aadhaar_number = "608737386151";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        centerTitle: true,
        title: const Text(
          "Aadhar Login",
        ),
      ),
      body: isWebViewOn
          ? SizedBox(
              height: screenWidth,
              width: screenWidth,
              child: WebView(
                initialUrl: link,
                zoomEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (url) async {
                  if (firstLink) {
                    for (int num = 1; num < 4; num++) {
                      aadhaar +=
                          (await webViewController.runJavascriptReturningResult(
                              "window.document.getElementById('aadhaar_$num').value = ${aadhaar_number.substring((num - 1) * 4, num * 4)};"));
                    }
                    await Future.delayed(
                        Duration(seconds: 1),
                        () async => await webViewController
                            .runJavascriptReturningResult(
                                "document.getElementsByName('sendButton')[0].click();"));
                  }
                  print(aadhaar);
                  firstLink = false;
                  print(url);
                  if (url ==
                      "https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=True&id=$requestID") {
                    isWebViewOn = false;
                    String rawJson =
                        (await webViewController.runJavascriptReturningResult(
                            "window.document.getElementsByTagName('html')[0].outerHTML;"));
                    setState(() {});
                    Map<String, dynamic> data = jsonDecode(
                      rawJson
                          .substring(
                            rawJson.indexOf('{'),
                            rawJson.lastIndexOf('}') + 1,
                          )
                          .replaceAll(r'\n', '')
                          .replaceAll(r'\', ''),
                    );

                    print(data);
                    Uint8List photo = base64Decode(data['aadhaar']['photo']);

                    imageReady = true;

                    // Loading image from aadhar card
                    image = Image.memory(photo);
                    setState(() {});
                  } else if (url ==
                      'https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=False&id=$requestID') {
                    print('failure');
                  }
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
              ),
            )
          : Center(
              child: Stack(
                children: [
                  imageReady
                      ? image
                      : Container(
                          width: screenWidth,
                          height: screenHeight,
                          child: Center(
                            child: LoadingAnimationWidget.bouncingBall(
                              size: screenWidth / 2,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                  ElevatedButton(
                    onPressed: () async {
                      isWebViewOn = true;
                      // isLoading = true;
                      // setState(() {});
                      Map<String, dynamic> results = await aadharSignIn();
                      // isLoading = false;
                      // setState(() {});

                      // print(results);
                      link = results['url'];
                      requestID = results['id'];
                      setState(() {});
                    },
                    child: Text("Login"),
                  ),
                  // isLoading
                  //     ? Container(
                  //         width: screenWidth,
                  //         height: screenHeight,
                  //         child: LoadingAnimationWidget.discreteCircle(
                  //             color: Colors.white,
                  //             size: screenWidth * 0.3,
                  //             secondRingColor: Colors.black,
                  //             thirdRingColor: Colors.purple),
                  //       )
                  //     : Container(),
                ],
              ),
            ),
    );
  }
}
