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

   List<Member> get members => chitMemberDataAccess.members;

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
         if(chitMemberDataAccess.members.length == 0){
            await chitMemberDataAccess.getMembers();
         }
         chitMemberDataAccess.deselectAll();
      }catch(e){
         print("Getting members failed $e");
      }finally{
         Future.delayed(Duration.zero, (){ setState(ViewState.Idle); });
      }
   }

   void markMemberAsSelected(Member selectedMember){
      try{
         chitMemberDataAccess.markMemberAsSelected(selectedMember);
      }catch(e){
         print("Error marking member as selected $e");
      }finally{
         Future.delayed(Duration.zero, (){ setState(ViewState.Idle); });
      }
   }

   Future<List<Member>> getMembersOfChit(int chitId) async {
      try{
         List<Member> members = await chitDataAccess.getMembersOfChit(chitId);
         return members;
      }catch(e){
         print("Error getting chit members info $e");
      }finally{
         Future.delayed(Duration.zero, (){ setState(ViewState.Idle); });
      }
   }

   Future<Map<String, dynamic>> addChitMember(int chitId, Member selectedMember) async {
      Map<String, dynamic> response = {};
      try{
         if(chitId == null){
            throw "Chit id is required";
         }
         setState(ViewState.Busy);
         Map<String, dynamic> body = {
            "member_id": selectedMember.id,
            "alias_name": selectedMember.aliasName
         };
         response =  await chitDataAccess.postChitMember(chitId, body);
      }catch(e){
         print("Error in ChitViewModel.addChitMember : $e");
      }finally{
         setState(ViewState.Idle);
      }
      return response;
   }

   Future<Map<String, dynamic>> replaceChitMember(int chitId, Member selectedMember, Member memberToBeReplaced) async {
      Map<String, dynamic> response = {};
      try{
         if(chitId == null){
            throw "Chit id is required";
         }
         setState(ViewState.Busy);
         Map<String, dynamic> body = {
            "id": memberToBeReplaced.chitMemberId,
            "member_id": selectedMember.id,
            "alias_name": selectedMember.aliasName
         };
         response =  await chitDataAccess.putChitMember(chitId, body);
      }catch(e){
         print("Error in ChitViewModel.replaceChitMember : $e");
      }finally{
         setState(ViewState.Idle);
      }
      return response;
   }

   Future<Map<String, dynamic>> createChit({ int chitTemplateId, String name, int chitDay, String status }) async {
      Map<String, dynamic> chitObj = {};
      try{
         if(chitTemplateId == null) throw "Select template to create chit";
         if(name == null || name.trim().length == 0) throw "Chit name should not be empty";
         if(chitDay == null) throw "Chit day should not be empty";

         Map<String, dynamic> body = {
            "chit_template_id": chitTemplateId,
            "name": name,
            "chit_day": chitDay,
            "status": status
         };
         chitObj = await chitDataAccess.postChit(body);
      }catch(e){
         print("Error in ChitViewModel.createChit : $e");
      }finally{
         setState(ViewState.Idle);
      }
      return chitObj;
   }
}