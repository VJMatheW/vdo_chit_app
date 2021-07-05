
import 'package:vdo_chit_app/core/enums_and_variables/info_state.dart';

import '../../core/data_access/chit_template_dataaccess.dart';
import '../../core/data_models/data_models.dart';
import '../../locator.dart';
import '../base_model.dart';

class ChitTemplateViewModel extends BaseModel{

   ChitTemplateDataAccess chitTemplateDataAccess = locator<ChitTemplateDataAccess>();

   List<ChitTemplate> chitTemplates = [];

   void init(){
      getChitTemplates();
   }

   void dispose(){
   }

   void getChitTemplates() async {
      try{
         setState(ViewState.Busy);
         chitTemplates = await chitTemplateDataAccess.getChitTemplates();
      }catch(e){
         print("Exception $e");
      }finally{
         setState(ViewState.Idle);
      }
   }

   Future<void> postChitTemplate(String amount, String percentage, String memberCount) async {
      try{
         // TODO data validation has to be done
         setState(ViewState.Busy);
         Map<String, int> chitTemplateMap = {
            "amount": int.parse(amount),
            "percentage": int.parse(percentage),
            "members_count": int.parse(memberCount)
         };
         ChitTemplate chitTemplate = await chitTemplateDataAccess.postAddNewChitTemplate(chitTemplateMap);
         cacheChitTemplate(chitTemplate);
         print("Successfully added new ChitTemplate");
      }catch(e){
         print("Exception $e");
      }finally{
         setState(ViewState.Idle);
      }
   }

   void cacheChitTemplate(ChitTemplate chitTemplate){
      chitTemplates.insert(0, chitTemplate);
      setState(ViewState.Idle);
   }
}