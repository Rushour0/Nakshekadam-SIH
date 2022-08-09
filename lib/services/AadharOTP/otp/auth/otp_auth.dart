import 'dart:convert';

import 'package:http/http.dart' as http;
import 'otp_auth_util.dart';

Future<Map<String, dynamic>> aadharSignIn() async {
  Uri url = Uri.parse("https://aadharotp.rushour0.repl.co/digilocker/initiate");
  http.Response response = await http.get(url);
  Map<String, dynamic> data = jsonDecode(response.body);
  Map<String, dynamic> result = {
    'sign_in_url': data['url'],
    'request_id': data['id']
  };

  return result;
}
