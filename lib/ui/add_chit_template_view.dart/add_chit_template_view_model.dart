import 'package:flutter/widgets.dart';

import '../base_model.dart';

class AddChitTemplateViewModel extends BaseModel{
   
   TextEditingController _chitAmountTextEditingController;

   void init(){
      _chitAmountTextEditingController = TextEditingController();
   }

   void dispose(){
      _chitAmountTextEditingController.dispose();
   }

   void postChitTemplates() async {
      try{
         
      }catch(e){
         print("Exception $e");
      }
   }
}