import '../data_models/data_models.dart';
import '../shared/services/http_service.dart';
import 'data_access.dart';

class MemberDataAccess extends BaseDataAccess{
   Future<List<Member>> getMembers() async {
      List<Member> members = [];

      HttpResponse response = await httpClient.get(url: "/member");
      handleResponseCode(response, 200);

      var memberArray = response.body["data"] as List;

      members = memberArray.map((member) => Member.fromJson(member)).toList();

      return members;
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