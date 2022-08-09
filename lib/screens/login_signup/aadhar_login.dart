import 'package:flutter/material.dart';
import 'package:nakshekadam/services/AadharOTP/otp/auth/otp_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AadharLoginPage extends StatefulWidget {
  const AadharLoginPage({Key? key}) : super(key: key);

  @override
  State<AadharLoginPage> createState() => _AadharLoginPageState();
}

class _AadharLoginPageState extends State<AadharLoginPage> {
  late WebViewController webViewController;
  bool isWebViewOn = false;
  String requestID = "", link = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Aadhar Login",
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      body: isWebViewOn
          ? WebView(
              initialUrl: link,
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (url) {
                if (url.startsWith('https://setu.co/?success=')) {
                  isWebViewOn = false;
                  setState(() {});
                }
              },
              onWebViewCreated: (controller) {
                webViewController = controller;

                webViewController.currentUrl();
              },
            )
          : ElevatedButton(
              onPressed: () async {
                isWebViewOn = true;
                Map<String, dynamic> results = await aadharSignIn();
                print(results);
                link = results['sign_in_url'];
                requestID = results['request_id'];
                setState(() {});
              },
              child: Text("Login"),
            ),
    );
  }
}
