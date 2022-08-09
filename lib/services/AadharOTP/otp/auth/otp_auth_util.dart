import 'dart:convert';

class URLHandler {}

class ResponseHandler {
  String? status;
  int? errcode;

  ResponseHandler(String responsejson) {
    var response = jsonDecode(responsejson);
    status = response['status'];
    errcode = int.parse(response['errCode'] ?? "0");
  }
}
