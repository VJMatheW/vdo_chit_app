import 'dart:io';

import 'package:vdo_chit_app/core/data_access/data_access.dart';

import '../data_models/chit_datamodel.dart';
import '../data_models/chit_template_datamodel.dart';
import '../data_models/data_models.dart';

import '../../locator.dart';
import '../shared/services/http_service.dart';

class ChitDataAccess extends BaseDataAccess{
   final HttpService _httpClient = locator<HttpService>();

   Future<List<ChitInfo>> getActiveChit() async {
      List<ChitInfo> chitInfos = [];
      
      HttpResponse response = await  _httpClient.get(url: "/chit/active");
      handleResponseCode(response, 200);

      var chitArray = response.body["data"] as List;
      
      chitInfos = chitArray.map(( chitObj ){
         // creating chit template 
         ChitTemplate chitTemplate = ChitTemplate.fromJson(chitObj["chitTemplate"]);

         // creating [Installment[bidder], ]
         List<Installment> installments = (chitObj["installments"] as List).map((installmentObj){
            var bidderObj = installmentObj["bidder"];
            Bidder bidder = Bidder.fromJson(bidderObj);
            Installment installment = Installment.fromJson(installmentObj, bidder);
            return installment;
         }).toList();
         
         // creating chit info
         ChitInfo chitInfo = ChitInfo.fromJson(chitObj, chitTemplate, installments);
         
         return chitInfo;

      }).toList();
      return chitInfos;
   }

   Future<List<ChitInfo>> getChits() async {
      List<ChitInfo> chitInfos = [];
      
      HttpResponse response = await  _httpClient.get(url: "/chit");
      handleResponseCode(response, 200);

      var chitArray = response.body["data"] as List;
      
      chitInfos = chitArray.map(( chitObj ){
         // creating chit template 
         ChitTemplate chitTemplate = ChitTemplate.fromJson(chitObj["chitTemplate"]);
         
         // creating chit info
         ChitInfo chitInfo = ChitInfo.fromJsonForChitView(jsonObject: chitObj, chitTemplate: chitTemplate);
         
         return chitInfo;

      }).toList();
      return chitInfos;
   }

   Future<List<Member>> getMembersOfChit(int chitId) async {
      List<Member> members = [];

      if(chitId != null){
         HttpResponse response = await _httpClient.get(url: "/chit/$chitId/members");
         handleResponseCode(response, 200);

         var chitObj = response.body["data"];
         var memberArray = chitObj["members"] as List;

         members = memberArray.map((memberObj){
            return Member.fromJson(memberObj);
         }).toList();
      }
      
      return members;
   }

   Future<Map<String, dynamic>> postChitMember(int chitId, Map body) async {
      /**
       *  {
            "chit_id": "7",
            "member_id": 1,
            "created_by": 1,
            "org_id": 1,
            "alias_name": "test",
            "id": 9
         }
       */
      HttpResponse response = await _httpClient.post(url: "/chit/$chitId/member", body: body);
      handleResponseCode(response, 201);

      var chitMemberObj = response.body["data"] as Object;
      return chitMemberObj;
   }

   Future<Map<String, dynamic>> putChitMember(int chitId, Map body) async {
      HttpResponse response = await _httpClient.put(url: "/chit/$chitId/member", body: body);
      handleResponseCode(response, 201);

      var chitMemberObj = response.body["data"] as Object;
      return chitMemberObj;
   }

   Future<Map<String, dynamic>> postChit(Map body) async {
      HttpResponse response = await httpClient.post(url: "/chit", body: body);
      handleResponseCode(response, 201);

      var chitObject = response.body["data"] as Object;
      return chitObject;
   }
}