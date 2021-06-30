import 'dart:io';

import 'package:vdo_chit_app/core/data_models/chit_datamodel.dart';
import 'package:vdo_chit_app/core/data_models/chit_template_datamodel.dart';
import 'package:vdo_chit_app/core/data_models/data_models.dart';

import '../../locator.dart';
import '../shared/services/http_service.dart';

class ChitDataAccess{
   final HttpService _httpClient = locator<HttpService>();

   Future<List<ChitInfo>> getActiveChit() async {
      List<ChitInfo> chitInfos = [];
      HttpResponse response = await  _httpClient.get(url: "/chit/active");
      if(response.statusCode != 200){
         throw Exception({ "errorCode": response.statusCode, "error": response.body['error'] });
      }

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
}