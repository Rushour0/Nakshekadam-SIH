import 'package:http/http.dart' as http;
import 'otp_request_util.dart';

Future<String> generateOTPAPI(String aadhar) async {
  RequestHandler request = RequestHandler.uid(aadhar);
  URLHandler url = URLHandler();
  ResponseHandler? response;
  print(request.getBody());
  http.Response httpresponse = await http.post(url.url,
      headers: {'Content-type': 'application/json'}, body: request.getBody());
  if (httpresponse.statusCode == 200) {
    response = ResponseHandler(httpresponse.body);
  } else {
    print("Kahitari error with status code ${httpresponse.statusCode}");
    throw Exception("http response failed");
  }
  print(response.status);
  print(response.errcode);
  return Future.value(request.txnId);
}
