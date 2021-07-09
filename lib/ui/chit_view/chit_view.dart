import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdo_chit_app/core/shared/ui/widgets/widgets.dart';

import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'chit_view_model.dart';

class ChitView extends StatelessWidget {
  const ChitView({ Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<ChitViewModel>(),
         onModelReady: (model) => model.init(),
         builder: (context, ChitViewModel model, child){
            return Scaffold(
               backgroundColor: model.theme.background,
               appBar: AppBar(
                  backgroundColor: model.theme.primary,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.add, size: 30,), 
                        onPressed: ()=>{ Navigator.of(context).pushNamed('/addchit') }
                     )
                  ],
                  title: Text(model.language.appBarChit),
               ),
               body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: model.state == ViewState.Busy
                     ? Center(child: CupertinoActivityIndicator(),)
                     : ChitList(),
               ),
            );
         },
      );
   }
}

class ChitList extends BaseModelWidget<ChitViewModel>{
   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chits.length,
         itemBuilder: (context, index){
            ChitInfo chit = model.chits[index];
            return GestureDetector(
               onLongPress: (){
                  print("Long pressed.. show edit chit icons");
               },
               child: CustomCard(
                  model: model,
                  customCardGestures: CustomCardGestures(
                     onTap: (){
                        print("Move to next screen");
                     },
                  ),
                  child: Stack(
                     children: [
                        Positioned(
                           top: 2,
                           right: 2,
                           child: Container(
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(3.0),
                                 color: model.theme.primary,
                              ),                              
                              child: Padding(
                                 padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
                                 child: Text(chit.status, 
                                    style: TextStyle( color: model.theme.white, fontSize: 8.0, fontWeight: FontWeight.w700 ),
                                 ),
                              ),
                           )
                        ),
                        // actual content                        
                        Padding(
                           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                           /// ROW 1
                           child: Column(
                              children: [

                                 /// ROW 1
                                 Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Expanded( 
                                          flex: 1, 
                                          child: Cell(
                                             label: model.language.labelChitName, 
                                             value: chit.name, 
                                             model: model,
                                             valueFontSize: 15.0,
                                          )
                                       ), 
                                       Expanded(
                                          flex: 1,
                                          child: Cell(
                                             label: model.language.labelChitMembersAddedCount, 
                                             value: chit.addedMembersCount, 
                                             model: model
                                          ), 
                                       ),                                
                                    ],
                                 ),
                                 SizedBox(height: 10.0,),
                                 /// ROW 2
                                 Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Expanded(
                                          flex: 1,
                                          child: Cell(
                                             label: model.language.labelChitDate, 
                                             value: chit.chitDay, 
                                             model: model
                                          ), 
                                       ), 
                                       Expanded(
                                          flex: 1,
                                          child: Cell(
                                             label: model.language.labelChitMembersCount, 
                                             value: chit.chitTemplate.membersCount, 
                                             model: model
                                          ), 
                                       ),                                
                                    ],
                                 ),
                                 SizedBox(height: 10.0,),
                                 /// ROW 3
                                 Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Expanded( 
                                          flex: 1, 
                                          child: Cell(
                                             label: model.language.labelChitValue, 
                                             value: chit.chitTemplate.amount, 
                                             model: model
                                          )
                                       ),
                                       Expanded(
                                          flex: 1,
                                          child: Cell(
                                             label: model.language.labelChitPercentage, 
                                             value: chit.chitTemplate.percentage, 
                                             model: model
                                          ), 
                                       ),                                 
                                    ],
                                 ),
                              ],
                           ),
                        ),
                     ],
                  ),
               ),
            );
         },
      );
   }
}