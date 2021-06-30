class Member{
   int _id;
   String _phone;
   String _name;
   int _creditAmount;

   Member({ int id, String phone, String name, int creditAmount }){
      this._id = id;
      this._phone = phone;
      this._name = name;
      this._creditAmount = creditAmount;
   }

   factory Member.fromJson(Map<String, dynamic> jsonObject){
      return Member(
         id: jsonObject["id"],
         name: jsonObject["name"],
         phone: jsonObject["phone"],
         creditAmount: jsonObject["credit_amount"] ?? 0
      );
   }

   int get id => _id;
   String get phone => _phone;
   String get name => _name;
   int get creditAmount => _creditAmount;
}