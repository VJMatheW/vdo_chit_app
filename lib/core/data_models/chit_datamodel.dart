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

   void setId(int id){
      this._id = id;
   }

   void setName(String name){
      this._name =  name;
   }

   void setDay(int day){
      this._chitDay = day;
   }
}

class ChitInfo extends Chit{
   ChitTemplate _chitTemplate;
   List<Installment> _installments;
   int _addedMembersCount;
   List<Member> _members;

   ChitInfo({ int id, String name, int chitDay, String status, int addedMembersCount, ChitTemplate chitTemplate, List<Installment> installments, List<Member> members })
   : super(id: id, name: name, chitDay: chitDay, status: status){
      _chitTemplate = chitTemplate;
      _installments = installments;
      _addedMembersCount = addedMembersCount;
      _members = members ?? [];
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

   factory ChitInfo.fromJsonForChitView({ Map<String, dynamic> jsonObject, ChitTemplate chitTemplate, List<Member> members }){
      return ChitInfo(
         id: jsonObject["id"],
         name: jsonObject["name"],
         chitDay: jsonObject["chit_day"],
         status: jsonObject["status"],
         addedMembersCount: jsonObject["added_members_count"],
         chitTemplate: chitTemplate,
         members: members,
      );
   }

   ChitTemplate get chitTemplate => _chitTemplate;
   List<Installment> get installments => _installments;
   int get addedMembersCount => _addedMembersCount;
   List<Member> get members => _members;

   void setMembers(List<Member> members){
      this._members = members;
   }

   void addMember(Member member){
      this._members.add(member);
   }

   void setChitTemplate(ChitTemplate chitTemplate){
      this._chitTemplate = chitTemplate;
   }
}