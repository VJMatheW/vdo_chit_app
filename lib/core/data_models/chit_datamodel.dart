import 'chit_template_datamodel.dart';
import 'data_models.dart';

class Chit{
   int _id;
   String _name;
   int _chitDay;
   String _status;   

   Chit({ int id, String name, int chitDay, String status }){
      _id = id;
      _name = name;
      _chitDay = chitDay;
      _status = status;
   }

   int get id => _id;
   String get name => _name;
   int get chitDay => _chitDay;
   String get status => _status;
}

class ChitInfo extends Chit{
   ChitTemplate _chitTemplate;
   List<Installment> _installments;

   ChitInfo({ int id, String name, int chitDay, String status, ChitTemplate chitTemplate, List<Installment> installments })
   : super(id: id, name: name, chitDay: chitDay, status: status){
      _chitTemplate = chitTemplate;
      _installments = installments;
   }

   factory ChitInfo.fromJson(Map<String, dynamic> jsonObject, ChitTemplate chitTemplate, List<Installment> installments){
      return ChitInfo(
         id: jsonObject["id"],
         name: jsonObject["name"],
         chitDay: jsonObject["chit_day"],
         status: jsonObject["status"],
         chitTemplate: chitTemplate,
         installments: installments
      );
   }

   ChitTemplate get chitTemplate => _chitTemplate;
   List<Installment> get installments => _installments;
}