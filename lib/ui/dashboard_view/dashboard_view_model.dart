import 'package:vdo_chit_app/core/data_models/data_models.dart';
import 'package:vdo_chit_app/core/enums_and_variables/info_state.dart';

import '../../core/data_access/data_access.dart';

import '../../locator.dart';
import '../base_model.dart';

class DashboardViewModel extends BaseModel{
   
   ChitDataAccess chitDataAccess = locator<ChitDataAccess>();
   
   List<ChitInfo> chitsInfo = [];
   List<Member> suggestedMembers = [];

   void init(){
      getActiveChits();
   }

   List<Member> searchMember(String query){
      print("Received SearchMember query : $query");
      query = query.trim().toLowerCase();      
      List<Member> members = [
         Member(name: 'Vijay', phone: '9042307071'),
         Member(name: 'Meenakshi', phone: '9840941369'),
         Member(name: 'Prabhu', phone: '9952104432'),
         Member(name: 'Gopi', phone: '9952704120'),
         Member(name: 'Ravi', phone: '9894228324'),
         Member(name: 'Srinivasan', phone: '9444722757'),
      ];

      if(query == ""){
         suggestedMembers = [];
      }else{
         suggestedMembers = members.where((member){
            return member.name.toLowerCase().contains(query) || member.phone.toLowerCase().contains(query);
         }).toList();

         print('Matched member count ${suggestedMembers.length}');
      }
      return suggestedMembers;
   }

   void getActiveChits() async {
      try{
         setState(ViewState.Busy);
         chitsInfo = await chitDataAccess.getActiveChit();
         print("Successfully retrieved ${chitsInfo.length}");
      }catch(e){
         print("Error gettingActiveChits $e");
      }finally{
         setState(ViewState.Idle);
      }
   }
}