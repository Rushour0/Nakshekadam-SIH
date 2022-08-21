import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nakshekadam/common_widgets/backgrounds/bigTwoSmallOneBg.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/services/AadharOTP/otp/auth/otp_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AadharLoginPage extends StatefulWidget {
  const AadharLoginPage({Key? key}) : super(key: key);

  @override
  State<AadharLoginPage> createState() => _AadharLoginPageState();
}

class _AadharLoginPageState extends State<AadharLoginPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController aadharController = TextEditingController();
  late WebViewController webViewController;
  late Image image;
  bool isWebViewOn = false;
  bool imageReady = false;
  bool isLoading = false;

  bool firstLink = true;

  String requestID = "", link = "", aadhaar = "", otp = "";

  void resetWebView() {
    isWebViewOn = false;
    firstLink = true;
    isLoading = false;
    requestID = "";

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

    SnackBar aadharLoginStatus(isSuccess) => SnackBar(
          content: Text(
            "Aadhar Login ${isSuccess ? 'Success' : 'Failed'}",
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenWidth * 0.04,
              color: COLOR_THEME['buttonText'],
            ),
          ),
          backgroundColor: COLOR_THEME['buttonBackground'],
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: isWebViewOn
          ? AppBar(
              centerTitle: true,
              title: Text(
                "Aadhar Login",
                style: TextStyle(
                  fontFamily: 'Cabin',
                  fontSize: screenWidth * 0.075,
                  color: COLOR_THEME['appBarText'],
                ),
              ),
              backgroundColor: COLOR_THEME['primary'],
            )
          : null,
      floatingActionButton: isWebViewOn
          ? null
          : SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: COLOR_THEME['buttonBackground'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.01),
                  ),
                ),
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    aadhaar = aadharController.text;
                    print("MY AADHAR:$aadhaar");
                    isWebViewOn = true;

                    Map<String, dynamic> results = await aadharSignIn();

                    link = results['url'];
                    requestID = results['id'];
                    setState(() {});
                    // Navigator.of(context).push(
                    //   CustomPageRouter(
                    //     child: PhoneAuthOTP(
                    //       mobileNumber: _mobileNumberController.text.trim(),
                    //     ),
                    //   ),
                    // );
                  }
                },
                child: Text(
                  "CONTINUE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cabin',
                    fontSize: screenWidth * 0.06,
                    color: COLOR_THEME['buttonText'],
                  ),
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: isWebViewOn
          ? SizedBox(
              height: screenHeight * 0.9,
              width: screenWidth,
              child: WebView(
                initialUrl: link,
                zoomEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: (url) async {
                  print(await webViewController.getTitle());
                  if (firstLink) {
                    for (int num = 1; num < 4; num++) {
                      (await webViewController.runJavascriptReturningResult(
                          "window.document.getElementById('aadhaar_$num').value = ${aadhaar.substring((num - 1) * 4, num * 4)};"));
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

                    ScaffoldMessenger.of(context)
                        .showSnackBar(aadharLoginStatus(true));
                    // Loading image from aadhar card
                    image = Image.memory(photo);
                    resetWebView();
                  } else if (url ==
                      'https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=False&id=$requestID') {
                    print('failure');
                    resetWebView();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(aadharLoginStatus(false));
                  }
                },
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
              ),
            )
          : Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    height: screenHeight,
                    width: screenWidth,
                    child: const BigTwoSmallOneBG(),
                  ),
                  Positioned(
                    top: 0,
                    width: screenWidth,
                    bottom: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.007),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: Text(
                                      "BACK",
                                      style: TextStyle(
                                        fontFamily: "Cabin",
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff615793),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(context, '/login');
                                    },
                                    style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    child: Text(
                                      "SKIP",
                                      style: TextStyle(
                                        fontFamily: "Cabin",
                                        fontSize: screenWidth * 0.06,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff615793),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.05),
                              child: Image.asset(
                                'assets/images/verifyCenterImage.png',
                                width: screenWidth * 0.7,
                                height: screenWidth * 0.7,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.02),
                              child: Text(
                                "VERIFY YOUR AADHAR NUMBER",
                                style: TextStyle(
                                  fontFamily: "DM Sans",
                                  fontSize: screenWidth * 0.06,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff32324D),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (overscroll) {
                                overscroll.disallowIndicator();
                                return true;
                              },
                              child: Expanded(
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.02),
                                      child: TextFormField(
                                        style: TextStyle(
                                            color:
                                                COLOR_THEME['formFieldText']),
                                        controller: aadharController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter your aadhar number";
                                          } else if (value.length != 12) {
                                            return "Aadhar number is 12 length long";
                                          } else {
                                            return null;
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .singleLineFormatter,
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "XXXX-XXXX-XXXX",
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              screenWidth * 0.05,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
    // Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   body: isWebViewOn
    //       ? SizedBox(
    //           height: screenWidth,
    //           width: screenWidth,
    //           child: WebView(
    //             initialUrl: link,
    //             zoomEnabled: false,
    //             javascriptMode: JavascriptMode.unrestricted,
    //             onPageStarted: (url) async {
    //               if (firstLink) {
    //                 for (int num = 1; num < 4; num++) {
    //                   aadhaar +=
    //                       (await webViewController.runJavascriptReturningResult(
    //                           "window.document.getElementById('aadhaar_$num').value = ${aadhaar_number.substring((num - 1) * 4, num * 4)};"));
    //                 }
    //                 await Future.delayed(
    //                     Duration(seconds: 1),
    //                     () async => await webViewController
    //                         .runJavascriptReturningResult(
    //                             "document.getElementsByName('sendButton')[0].click();"));
    //               }
    //               print(aadhaar);
    //               firstLink = false;
    //               print(url);
    //               if (url ==
    //                   "https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=True&id=$requestID") {
    //                 isWebViewOn = false;
    //                 String rawJson =
    //                     (await webViewController.runJavascriptReturningResult(
    //                         "window.document.getElementsByTagName('html')[0].outerHTML;"));
    //                 setState(() {});
    //                 Map<String, dynamic> data = jsonDecode(
    //                   rawJson
    //                       .substring(
    //                         rawJson.indexOf('{'),
    //                         rawJson.lastIndexOf('}') + 1,
    //                       )
    //                       .replaceAll(r'\n', '')
    //                       .replaceAll(r'\', ''),
    //                 );

    //                 print(data);
    //                 Uint8List photo = base64Decode(data['aadhaar']['photo']);

    //                 imageReady = true;

    //                 // Loading image from aadhar card
    //                 image = Image.memory(photo);
    //                 setState(() {});
    //               } else if (url ==
    //                   'https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=False&id=$requestID') {
    //                 print('failure');
    //               }
    //             },
    //             onWebViewCreated: (controller) {
    //               webViewController = controller;
    //             },
    //           ),
    //         )
    //       : Container(
    //           color: Colors.white,
    //           child: Stack(
    //             children: [
    //               Positioned(
    //                 height: screenHeight,
    //                 width: screenWidth,
    //                 child: const BigTwoSmallOneBG(),
    //               ),
    //               Positioned(
    //                 top: 0,
    //                 width: screenWidth,
    //                 bottom: 0,
    //                 child: SafeArea(
    //                   child: Padding(
    //                     padding: EdgeInsets.symmetric(
    //                         horizontal: screenWidth * 0.04,
    //                         vertical: screenHeight * 0.007),
    //                     child: Column(
    //                       children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Align(
    //                               alignment: Alignment.topLeft,
    //                               child: TextButton(
    //                                 onPressed: () {
    //                                   Navigator.pop(context);
    //                                 },
    //                                 style: ButtonStyle(
    //                                   overlayColor: MaterialStateProperty.all(
    //                                       Colors.transparent),
    //                                 ),
    //                                 child: Text(
    //                                   "BACK",
    //                                   style: TextStyle(
    //                                     fontFamily: "Cabin",
    //                                     fontSize: screenWidth * 0.06,
    //                                     fontWeight: FontWeight.w500,
    //                                     color: const Color(0xff615793),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.topRight,
    //                               child: TextButton(
    //                                 onPressed: () {
    //                                   // Navigator.pushNamed(context, '/login');
    //                                 },
    //                                 style: ButtonStyle(
    //                                   overlayColor: MaterialStateProperty.all(
    //                                       Colors.transparent),
    //                                 ),
    //                                 child: Text(
    //                                   "SKIP",
    //                                   style: TextStyle(
    //                                     fontFamily: "Cabin",
    //                                     fontSize: screenWidth * 0.06,
    //                                     fontWeight: FontWeight.w500,
    //                                     color: const Color(0xff615793),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(
    //                               top: screenHeight * 0.1,
    //                               bottom: screenHeight * 0.03),
    //                           child: Text(
    //                             "ENTER THE OTP SENT TO THE REGISTERED PHONE NUMBER OF YOUR AADHAAR CARD",
    //                             style: TextStyle(
    //                               fontFamily: "DM Sans",
    //                               fontSize: screenWidth * 0.06,
    //                               fontWeight: FontWeight.w600,
    //                               color: const Color(0xff32324D),
    //                             ),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                         NotificationListener<
    //                             OverscrollIndicatorNotification>(
    //                           onNotification: (overscroll) {
    //                             overscroll.disallowIndicator();
    //                             return true;
    //                           },
    //                           child: Expanded(
    //                             child: SingleChildScrollView(
    //                               child: Column(
    //                                 children: [
    //                                   Align(
    //                                     alignment: Alignment.topLeft,
    //                                     child: TextButton(
    //                                       onPressed: () {
    //                                         Navigator.pop(context);
    //                                       },
    //                                       child: Text(
    //                                         "Edit Aadhar Number?",
    //                                         style: TextStyle(
    //                                             decoration:
    //                                                 TextDecoration.underline,
    //                                             fontFamily: "Nunito",
    //                                             fontSize: screenWidth * 0.045,
    //                                             color: const Color(0xff1A67F9)),
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    // );
    //   isWebViewOn
    //       ? SizedBox(
    //           height: screenWidth,
    //           width: screenWidth,
    //           child: WebView(
    //             initialUrl: link,
    //             zoomEnabled: false,
    //             javascriptMode: JavascriptMode.unrestricted,
    //             onPageStarted: (url) async {
    //               if (firstLink) {
    //                 for (int num = 1; num < 4; num++) {
    //                   aadhaar +=
    //                       (await webViewController.runJavascriptReturningResult(
    //                           "window.document.getElementById('aadhaar_$num').value = ${aadhaar_number.substring((num - 1) * 4, num * 4)};"));
    //                 }
    //                 await Future.delayed(
    //                     Duration(seconds: 1),
    //                     () async => await webViewController
    //                         .runJavascriptReturningResult(
    //                             "document.getElementsByName('sendButton')[0].click();"));
    //               }
    //               print(aadhaar);
    //               firstLink = false;
    //               print(url);
    //               if (url ==
    //                   "https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=True&id=$requestID") {
    //                 isWebViewOn = false;
    //                 String rawJson =
    //                     (await webViewController.runJavascriptReturningResult(
    //                         "window.document.getElementsByTagName('html')[0].outerHTML;"));
    //                 setState(() {});
    //                 Map<String, dynamic> data = jsonDecode(
    //                   rawJson
    //                       .substring(
    //                         rawJson.indexOf('{'),
    //                         rawJson.lastIndexOf('}') + 1,
    //                       )
    //                       .replaceAll(r'\n', '')
    //                       .replaceAll(r'\', ''),
    //                 );

    //                 print(data);
    //                 Uint8List photo = base64Decode(data['aadhaar']['photo']);

    //                 imageReady = true;

    //                 // Loading image from aadhar card
    //                 image = Image.memory(photo);
    //                 setState(() {});
    //               } else if (url ==
    //                   'https://aadharotp.rushour0.repl.co/digilocker/aadhar?success=False&id=$requestID') {
    //                 print('failure');
    //               }
    //             },
    //             onWebViewCreated: (controller) {
    //               webViewController = controller;
    //             },
    //           ),
    //         )
    //       : Center(
    //           child: Stack(
    //             children: [
    //               imageReady
    //                   ? image
    //                   : Container(
    //                       width: screenWidth,
    //                       height: screenHeight,
    //                       child: Center(
    //                         child: LoadingAnimationWidget.bouncingBall(
    //                           size: screenWidth / 2,
    //                           color: Colors.amber,
    //                         ),
    //                       ),
    //                     ),
    //               ElevatedButton(
    //                 onPressed: () async {
    //                   isWebViewOn = true;
    //                   // isLoading = true;
    //                   // setState(() {});
    //                   Map<String, dynamic> results = await aadharSignIn();
    //                   // isLoading = false;
    //                   // setState(() {});

    //                   // print(results);
    //                   link = results['url'];
    //                   requestID = results['id'];
    //                   setState(() {});
    //                 },
    //                 child: Text("Login"),
    //               ),
    //               // isLoading
    //               //     ? Container(
    //               //         width: screenWidth,
    //               //         height: screenHeight,
    //               //         child: LoadingAnimationWidget.discreteCircle(
    //               //             color: Colors.white,
    //               //             size: screenWidth * 0.3,
    //               //             secondRingColor: Colors.black,
    //               //             thirdRingColor: Colors.purple),
    //               //       )
    //               //     : Container(),
    //             ],
    //           ),
    //         ),
    // );
  }
}
