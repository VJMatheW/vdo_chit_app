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

   Future<HttpResponse> post({ @required String url, Map<String, String> headers = header, @required Object body }) async{
      print("POST $baseUrl$url");
      HttpRequest httpRequest = HttpRequest("$baseUrl$url", body);
      final response = await httpClient.post(httpRequest.url, body: httpRequest.body, headers: headers);
      return HttpResponse(response.statusCode, response.body);
   }
}

class HttpResponse{
   int _statusCode;
   Map<String, dynamic> _body;

   HttpResponse(int statusCode,String body){      
      _statusCode = statusCode;
      _body = jsonDecode(body);
   }

   int get statusCode => _statusCode;
   Map<String, dynamic> get body => _body;
}

class HttpRequest{
   Uri _url;
   String _jsonBodyString;

   HttpRequest(String url, Object body){
      _url = Uri.parse(url);
      _jsonBodyString = jsonEncode(body);
   }

   Uri get url => _url;
   String get body => _jsonBodyString;
}