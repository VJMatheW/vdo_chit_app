
import '../../core/data_access/chit_dataaccess.dart';
import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../locator.dart';
import '../base_model.dart';

class ChitInfoViewModel extends BaseModel{

   int chitId;
   ChitDataAccess chitDataAccess = locator<ChitDataAccess>();
   
   ChitInfo chitInfo; 

   void init(){
      getChitInstallments(this.chitId);
   }

   void dispose(){
   }

   void setChitId(data){
      this.chitId = data["chitId"];
   }

   void getChitInstallments(int chitId) async {
      try{
         setState(ViewState.Busy);
         chitInfo = await chitDataAccess.getChitInstallments(chitId);
         print("Successfully retrieved chit installments");
      }catch(e){
         print("Error gettingChitInstallments $e");
      }finally{
         setState(ViewState.Idle);
      }
   }
}