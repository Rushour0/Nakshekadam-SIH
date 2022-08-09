import 'dart:convert';

import 'package:uuid/uuid.dart';

class URLHandler {
  Uri url = Uri.parse("https://stage1.uidai.gov.in/onlineekyc/getOtp/");
}

class RequestHandler {
  String? uid;
  String? vid;
  String? txnId = "0acbaa8b-b3ae-433d-a5d2-51250ea8e970";

  RequestHandler.uid(this.uid) {
    const uuid = Uuid();
    txnId = uuid.v4();
  }
  RequestHandler.vid(this.vid);
  String? getBody() {
    if (vid == null && uid == null) {
      throw Exception("Both uid and vid null");
    } else if (uid == null) {
      return json.encode({'vid': vid, 'txnId': txnId});
    } else if (vid == null) {
      return json.encode({'uid': uid, 'txnId': txnId});
    }
  }
}

class ResponseHandler {
  String? status;
  int? errcode;

  ResponseHandler(String responsejson) {
    var response = jsonDecode(responsejson);
    status = response['status'];
    errcode = int.parse(response['errCode'] ?? "0");
  }
}
