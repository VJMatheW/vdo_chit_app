import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vdo_chit_app/core/enums_and_variables/variables.dart';

class HttpService {

   final httpClient;
   static const Map<String, String> header = { "Content-Type": "application/json" };
   final baseUrl = Vars.API_HOST;

   HttpService(this.httpClient);

   void setToken(String token){
      header["Authorization"] = "Bearer $token";
   }

   void revokeToken(){
      header.remove("Authorization");
   }

   Future<HttpResponse> get({ @required String url, Map<String, String> headers = header }) async{
      print("GET $baseUrl$url");
      final response = await httpClient.get(Uri.parse("$baseUrl$url"), headers: headers);
      return HttpResponse(response.statusCode, response.body);
   }

   Future<HttpResponse> post({ @required String url, Map<String, String> headers = header, Object body }) async{
      print("POST $baseUrl$url");
      final response = await httpClient.post(Uri.dataFromString("$baseUrl$url"), body: body, headers: headers);
      return HttpResponse(response.statusCode, response.body);
   }
}

class HttpResponse{
   int _statusCode;
   Map<String, dynamic> _body;

   HttpResponse(this._statusCode, body){
      _body = jsonDecode(body);
   }

   int get statusCode => _statusCode;
   Map<String, dynamic> get body => _body;
}