import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vdo_chit_app/core/data_models/data_models.dart';
import '../preference_model.dart';

import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../core/shared/ui/widgets/widgets.dart';
import '../../locator.dart';
import '../base_model.dart';
import '../base_model_widget.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatefulWidget {

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
   bool toggle = true;

   @override
   void initState() {   
      super.initState();
   }

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
                  backgroundColor: Provider.of<PreferenceModel>(context).theme.primary,
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
                        child: DashboardChitList()
                           // children: [
                           //    ChitCard(),
                           //    ChitCard(),
                           //    ChitCard(),
                           //    ChitCard(),
                           //    ChitCard(),
                           //    ChitCard(),
                           //    ChitCard(),
                           //    ChitCard(),
                           // ],
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
         padding: const EdgeInsets.only( left: 12.0, right: 12.0, top: 20.0),
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

class DashboardChitList extends BaseModelWidget<DashboardViewModel> {

   @override
   Widget build(BuildContext context, DashboardViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chitsInfo.length,
         itemBuilder: (context, index){
            ChitInfo chitInfo = model.chitsInfo[index];
            return GestureDetector(
               onLongPress: (){
                  print("Long pressed show edit icons");
               },
               onTap: (){
                  print("Move to next screen");
               },
               child: Card(
                  margin: EdgeInsets.only(bottom: 15.0),
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
                                       child: Cell(
                                          label: model.language.lableChitName, 
                                          value: chitInfo.name, 
                                          model: model
                                       )
                                    ),
                                    Expanded(
                                       flex: 1,
                                       child: Cell(
                                          label: model.language.labelChitValue, 
                                          value: chitInfo.chitTemplate.amount, 
                                          model: model,
                                       ), 
                                    ),
                                 ],
                              ),
                              SizedBox(height: 15.0,),
                              
                              // ROW 2
                              Row(
                                 children: [
                                    Expanded( 
                                       flex: 1, 
                                       child: Cell(
                                          label: model.language.labelInstallmentNo, 
                                          value: chitInfo.installments[0].installmentNo, 
                                          model: model,
                                       ),
                                    ),
                                    Expanded(
                                       flex: 1,
                                       child: Cell(
                                          label: model.language.labelMembers, 
                                          value: chitInfo.chitTemplate.membersCount, 
                                          icon: Icons.supervisor_account, model: model,
                                       ),
                                    ),
                                 ],
                              ),

                              SizedBox(height: 15.0,),
                              
                              // ROW 3
                              Row(
                                 children: [
                                    Expanded(
                                       flex: 1,
                                       child: Cell(
                                          label: model.language.labelChitDate, 
                                          value: chitInfo.chitDay, 
                                          model: model,
                                       ),
                                    ),
                                    Expanded( 
                                       flex: 1, 
                                       child: Cell(
                                          label: model.language.labelPayableAmount, 
                                          value: chitInfo.installments[0].payableAmount, 
                                          model: model,
                                       ),
                                    ),
                                 ],
                              ),
                        ],
                     ),
                  ),
               ),
            );
         }
      );
   }
}