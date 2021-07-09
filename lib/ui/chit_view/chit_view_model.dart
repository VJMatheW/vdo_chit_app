import '../../core/data_access/data_access.dart';
import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../locator.dart';
import '../base_model.dart';

class ChitViewModel extends BaseModel{

   ChitDataAccess chitDataAccess = locator<ChitDataAccess>();
   ChitTemplateDataAccess chitTemplateDataAccess = locator<ChitTemplateDataAccess>();
   MemberDataAccess chitMemberDataAccess = locator<MemberDataAccess>();

   List<ChitInfo> chits = [];
   List<ChitTemplate> chitTemplates = [];
   List<Member> members = [];

   void init(){
      getChits();
   }

   void dispose(){}

   void getChits() async {
      try{
         setState(ViewState.Busy);
         chits = await chitDataAccess.getChits();         
      }catch(e){
         print("Getting chit failed $e");
      }finally{
         setState(ViewState.Idle);
      }
   }
   
   void getChitTemplates() async {
      try{
         if(chitTemplates.length == 0){
            chitTemplates = await chitTemplateDataAccess.getChitTemplates();
         }
         print("Template length ${chitTemplates.length}");
      }catch(e){
         print("Getting chitTemplates failed $e");
      }finally{
         Future.delayed(Duration.zero, (){ setState(ViewState.Idle); });
      }
   } 

   void getMembers() async {
      try{
         if(members.length == 0){
            members = await chitMemberDataAccess.getMembers();
         }
      }catch(e){
         print("Getting members failed $e");
      }finally{
         Future.delayed(Duration.zero, (){ setState(ViewState.Idle); });
      }
   }

}