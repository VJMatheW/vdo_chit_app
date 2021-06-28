import 'package:flutter/foundation.dart';

class HttpService {

   final httpClient;
   static const Map<String, String> header = { "Content-Type": "application/json" };

   HttpService(this.httpClient);

   void setToken(String token){
      header["Authorization"] = "Bearer $token";
   }

   void revokeToken(){
      header.remove("Authorization");
   }

   Future<HttpResponse> get({ @required String url, Map<String, String> headers = header }) async{
      final response = await httpClient.get(Uri.dataFromString(url), headers: headers);
      return HttpResponse(response.statusCode, response.body);
   }

   Future<HttpResponse> post({ @required String url, Map<String, String> headers = header, Object body }) async{
      final response = await httpClient.post(Uri.dataFromString(url), body: body, headers: headers);
      return HttpResponse(response.statusCode, response.body);
   }
}

class HttpResponse{
   int _statusCode;
   String _body;

   HttpResponse(this._statusCode, this._body);

   int get statusCode => _statusCode;
   String get body => _body;
}