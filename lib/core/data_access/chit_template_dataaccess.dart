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

   Future<ChitTemplate> postAddNewChitTemplate(Map<String, int> chitTemplateMap) async {
      ChitTemplate chitTemplate;

      HttpResponse response = await httpClient.post(url: "/chittemplate", body: chitTemplateMap);
      handleResponseCode(response, 201);

      var chitTemplateObject = response.body["data"] as Object;

      chitTemplate = ChitTemplate.fromJson(chitTemplateObject);

      return chitTemplate;
   }


}