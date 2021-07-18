import '../../core/data_access/member_dataaccess.dart';
import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../locator.dart';
import '../base_model.dart';

class MemberViewModel extends BaseModel{
   
   MemberDataAccess memberDataAccess = locator<MemberDataAccess>();
   
   List<Member> get members => memberDataAccess.members;

   void init(){
      getMembers();
   }

   void dispose(){}

   void getMembers() async {
      try{
         setState(ViewState.Busy);
         await memberDataAccess.getMembers();
         print("Member received ${memberDataAccess.members.length}");
      }catch(e){
         print("Exception $e");
      }finally{
         setState(ViewState.Idle);
      }
   }

   Future<bool> postMember(String name, String phone) async {
      try{
         setState(ViewState.Busy);
         Map<String, String> memberMap = {
            "name": name,
            "phone": phone
         };
         Member member = await memberDataAccess.postAddNewMember(memberMap);
         members.insert(0, member);
         return true;
      }catch(e){                
         print("Exception $e");
         return false;
      }finally{
         setState(ViewState.Idle);
      }     
   }
}