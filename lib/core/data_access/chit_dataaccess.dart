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
         ChitInfo chitInfo = ChitInfo.fromJsonForChitView(chitObj, chitTemplate);
         
         return chitInfo;

      }).toList();
      return chitInfos;
   }
}