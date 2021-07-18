import '../data_models/data_models.dart';
import '../shared/services/http_service.dart';
import 'data_access.dart';

class MemberDataAccess extends BaseDataAccess{

   List<Member> _members = [];

   List<Member> get members => _members;

   void markMemberAsSelected(Member selectedMember){
      int index = _members.indexWhere((member) => member.selected);
      if(index != -1){
         _members[index].deselect();  
      }
      selectedMember.markAsSelected();
   }

   void deselectAll(){
      for(int i = 0; i < _members.length; i++){
         _members[i].deselect();
      }
   }

   Future<void> getMembers() async {
      HttpResponse response = await httpClient.get(url: "/member");
      handleResponseCode(response, 200);

      var memberArray = response.body["data"] as List;

      _members = memberArray.map((member) => Member.fromJson(member)).toList();
   }

   Future<Member> postAddNewMember(Map<String , String> memberMap) async{
      Member member;

      HttpResponse response = await httpClient.post(url: "/member", body: memberMap);
      handleResponseCode(response, 201);

      var memberObject = response.body["data"] as Object;

      member = Member.fromJson(memberObject);

      return member;
   }
}