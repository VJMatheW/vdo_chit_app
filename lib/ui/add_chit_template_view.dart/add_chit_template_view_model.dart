
import 'package:vdo_chit_app/core/enums_and_variables/info_state.dart';

import '../../core/data_access/chit_template_dataaccess.dart';
import '../../core/data_models/data_models.dart';
import '../../locator.dart';
import '../base_model.dart';

class AddChitTemplateViewModel extends BaseModel{

   ChitTemplateDataAccess chitTemplateDataAccess = locator<ChitTemplateDataAccess>();

   List<ChitTemplate> chitTemplates = [];

   void init(){
   }

   void dispose(){
   }

   void postChitTemplates(String amount, String percentage, String memberCount) async {
      try{
         setState(ViewState.Busy);
         chitTemplates = await chitTemplateDataAccess.getChitTemplates();
      }catch(e){
         print("Exception $e");
      }finally{
         setState(ViewState.Idle);
      }
   }
}