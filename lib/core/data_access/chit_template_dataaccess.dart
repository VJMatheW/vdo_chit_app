import 'dart:async';

import '../data_models/data_models.dart';
import '../shared/services/http_service.dart';
import 'data_access.dart';

class ChitTemplateDataAccess extends BaseDataAccess{

   Future<List<ChitTemplate>> getChitTemplates() async {
      List<ChitTemplate> chitTemplates = [];
      
      HttpResponse response = await httpClient.get(url: "/chittemplate");
      handleResponseCode(response, 200);

      var chitTemplateArray = response.body["data"] as List;

      chitTemplates = chitTemplateArray.map(( chitTemplateobj ){
         // creating chit template
         ChitTemplate chitTemplate = ChitTemplate.fromJson(chitTemplateobj);
         return chitTemplate;
      }).toList();

      return chitTemplates;
   }

   Future<ChitTemplate> postAddNewChitTemplate(Map<String, int> chitTemplateObj) async {
      ChitTemplate chitTemplate;

      // HttpResponse response = await _ht

      return chitTemplate;
   }
}