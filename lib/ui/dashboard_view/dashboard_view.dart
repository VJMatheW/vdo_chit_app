import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_chit_app/ui/preference_model.dart';

import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../locator.dart';
import '../base_model.dart';
import '../base_model_widget.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {

   bool toggle = true;

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<DashboardViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context){
            return Scaffold(
               backgroundColor: Provider.of<PreferenceModel>(context).theme.background,
               floatingActionButton: FloatingActionButton(
                  onPressed: (){
                     if(toggle){
                        locator<DashboardViewModel>().setTamilLanguage();
                        locator<DashboardViewModel>().setDarkTheme();
                        toggle = false;
                     }else{
                        locator<DashboardViewModel>().setEnglishLanguage();
                        locator<DashboardViewModel>().setRegularTheme();
                        toggle = true;
                     }
                  }, 
                  child: Icon(Icons.add),),
               appBar: AppBar(
                  backgroundColor: Colors.red,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.settings), 
                        onPressed: ()=>{ print("open up settings") }
                     )
                  ],
                  title: Text("Organisation name"),
               ),
               body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [             
                     // search bar   
                     DashboardSearch(controller: new TextEditingController(),),
                     
                     // heading
                     DashboardHeading(),
                     
                     // DASHBOARD CARD LIST
                     Expanded( 
                        flex: 1, 
                        child: ListView(
                           padding: const EdgeInsets.symmetric(horizontal: 12.0),
                           physics: BouncingScrollPhysics(),
                           children: [
                              Stack(
                                 children: [
                                    ChitCard(),
                                    Positioned(
                                       right: 10,
                                       top: 25,
                                       child: Container(
                                          decoration: BoxDecoration(
                                             borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                             color: Colors.red[400]
                                          ),
                                          child: Padding(
                                             padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                                             child: Text("Paid", style: TextStyle(fontSize: 10.0),),
                                          ),
                                       ),
                                    ),
                                 ],
                              ),
                              ChitCard(),
                              ChitCard(),
                              ChitCard(),
                              ChitCard(),
                              ChitCard(),
                              ChitCard(),
                              ChitCard(),
                              ChitCard(),
                           ],
                        )
                     )
                  ],
               )
            ); 
         } // builder function
      );
   }
}

class DashboardSearch extends BaseModelWidget<DashboardViewModel>{
   final TextEditingController controller;
   DashboardSearch({ @required this.controller});
   @override
   Widget build(BuildContext context, DashboardViewModel model){
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
         child: UIWidgets.textInput(
            context: context,
            hintText: model.language.hintDashboardSearchMember,
            controller: controller,
            model: model,
            prefixIcon: Icons.search,
         )
      );
   }
}

class DashboardHeading extends BaseModelWidget<DashboardViewModel>{
   @override
   Widget build(BuildContext context, DashboardViewModel model){
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
         child: UIWidgets.heading(model.language.headingOngoingChits, model)
      );
   }
}

class ChitCard extends BaseModelWidget<DashboardViewModel> {

   final dynamic data;

   ChitCard({ this.data });

   @override
   Widget build(BuildContext context, BaseModel model) {
      return GestureDetector(
         onLongPress: (){
            print("Long pressed show edit icons");
         },
         onTap: (){
            print("Move to next screen");
         },
        child: Card(
           margin: EdgeInsets.only(top: 15.0),
           elevation: 3.0,
           child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                 children: [

                     // ROW 1
                     Row(
                        children: [
                           Expanded( 
                              flex: 1, 
                              child: Cell(label: model.language.lableChitName, value: "Group A 5L", model: model,)
                           ),
                           Expanded(
                              child: Cell(label: model.language.labelChitValue, value: 500000, model: model,), 
                              flex: 1,
                           ),
                        ],
                     ),
                     SizedBox(height: 15.0,),
                     
                     // ROW 2
                     Row(
                        children: [
                           Expanded( 
                              flex: 1, 
                              child: Cell(label: model.language.labelInstallmentNo, value: 1, model: model,),
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(label: model.language.labelMembers, value: 20, icon: Icons.supervisor_account, model: model,),
                           ),
                        ],
                     ),

                     SizedBox(height: 15.0,),
                     
                     // ROW 3
                     Row(
                        children: [
                           Expanded(
                              flex: 1,
                              child: Cell(label: model.language.labelChitDate, value: 5, model: model,),
                           ),
                           Expanded( 
                              flex: 1, 
                              child: Cell(label: model.language.labelPayableAmount, value: 20800, model: model,),
                           ),
                        ],
                     ),
                 ],
              ),
           ),
        ),
      );
   }
}


class Cell extends StatelessWidget {
   
   final label;
   final value;
   final icon;
   final isPhoneNumber;
   final BaseModel model;

   const Cell({ Key key, @required this.label, @required this.value, this.icon, this.isPhoneNumber = false, this.model }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            Expanded(
               flex: 1,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     // Label with icon
                     Row(
                        children: [
                           Text(
                              label, 
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                 fontSize: 10.0,
                                 color: model.theme.primary
                                 )
                              ),
                           // ICON
                           icon != null 
                           ? Padding(
                             padding: const EdgeInsets.only(left:8.0),
                             child: Icon(icon, color: model.theme.primary, size: 15,),
                           )
                           : Container()
                        ],
                     ),
                     // Value
                     Text(value.toString(),  
                        style: TextStyle(
                           fontSize: 20.0,
                           fontWeight: FontWeight.w400,
                           ),
                        // textAlign: TextAlign.left,
                     )
                  ],
               )
            ),
            
            // Phone icon
            !isPhoneNumber 
            ? Container()
            : GestureDetector(
               onTap: (){
                  print("Call the number");
               },
               child: Icon(Icons.phone_forwarded)
            )
         ],
      );
   }
}