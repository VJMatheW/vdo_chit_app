import '../../core/data_access/member_dataaccess.dart';
import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../locator.dart';
import '../base_model.dart';

class MemberViewModel extends BaseModel{

   List<Member> members = [];
   MemberDataAccess memberDataAccess = locator<MemberDataAccess>();

   void init(){
      getMembers();
   }

   void dispose(){}

   void getMembers() async {
      try{
         setState(ViewState.Busy);
         members = await memberDataAccess.getMembers();
         print("Member received ${members.length}");
      }catch(e){
         members = [];
         print("Exception $e");
      }finally{
         setState(ViewState.Idle);
      }
   }
}