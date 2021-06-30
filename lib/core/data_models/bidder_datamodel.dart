import 'member_datamodel.dart';

class Bidder extends Member{
   int _relationMemberId;
   String _aliasName;

   Bidder({ int id, String phone, String name, int creditAmount, int relationMemberId, String aliasName }) 
      : super(id:id, phone: phone, name: name, creditAmount: creditAmount){
      _relationMemberId = relationMemberId;
      _aliasName = aliasName;
   }

   factory Bidder.fromJson(Map<String, dynamic> jsonObject){
      return Bidder(
         id: jsonObject["id"],
         name: jsonObject["name"],
         phone: jsonObject["phone"],
         creditAmount: jsonObject["credit_amount"] ?? 0,
         relationMemberId: jsonObject["relation_member_id"],
         aliasName: jsonObject["alias_name"]
      );
   }

   int get relationMemberId => this._relationMemberId;
   String get aliasName => this._aliasName;
}