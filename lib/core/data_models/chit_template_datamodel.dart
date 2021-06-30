import 'package:vdo_chit_app/core/data_models/data_models.dart';

class ChitTemplate{
   int _id;
   int _amount;
   num _percentage;
   int _membersCount;

   ChitTemplate({ int id, int amount, num percentage, int membersCount }){
      this._id = id;
      this._amount = amount;
      this._percentage = percentage;
      this._membersCount = membersCount;
   }

   factory ChitTemplate.fromJson(Map<String, dynamic> jsonObject){
      return ChitTemplate(
         id: jsonObject["id"],
         amount: jsonObject["amount"],
         percentage: jsonObject["percentage"],
         membersCount: jsonObject["members_count"]
      );
   }

   int get id => _id;
   int get amount => _amount;
   int get percentage => _percentage.toInt();
   int get membersCount => _membersCount;
}