import 'package:vdo_chit_app/core/data_models/data_models.dart';
import 'package:vdo_chit_app/core/enums_and_variables/info_state.dart';

import '../../core/data_access/data_access.dart';

import '../../locator.dart';
import '../base_model.dart';

class DashboardViewModel extends BaseModel{
   
   ChitDataAccess chitDataAccess = locator<ChitDataAccess>();
   
   List<ChitInfo> chitsInfo = [];

   void init(){
      getActiveChits();
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