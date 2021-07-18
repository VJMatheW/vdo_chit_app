class Member{
   int _id;
   String _phone;
   String _name;
   int _creditAmount;
   String _aliasName;
   int _chitMemberId;
   // used when selecting member for a chit
   bool _selected = false;

   Member({ int id, String phone, String name, int creditAmount, String aliasName, int chitMemberId }){
      this._id = id;
      this._phone = phone;
      this._name = name;
      this._creditAmount = creditAmount;
      this._aliasName = aliasName;
      this._chitMemberId = chitMemberId;
   }

   factory Member.fromJson(Map<String, dynamic> jsonObject){
      return Member(
         id: jsonObject["id"],
         name: jsonObject["name"],
         phone: jsonObject["phone"],
         creditAmount: jsonObject["credit_amount"] ?? 0,
         chitMemberId: jsonObject["relation_member_id"],
      );
   }

   factory Member.fromInstance(Member member){
      return new Member(
         id: member.id,
         name: member.name,
         phone: member.phone,
         creditAmount: member.creditAmount,
         aliasName: member.aliasName,
         chitMemberId: member.chitMemberId,
      );
   }

   @override
   String toString(){
      return "$_name is $_selected";
   }

   int get id => _id;
   String get phone => _phone;
   String get name => _name;
   int get creditAmount => _creditAmount;
   bool get selected => _selected;
   String get aliasName => _aliasName;
   int get chitMemberId => _chitMemberId;

   void setAliasName(String aliasName){
      this._aliasName = aliasName;
   }

   void markAsSelected(){
      this._selected = true;
   }

   void deselect(){
      this._selected = false;
   }
}