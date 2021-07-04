import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vdo_chit_app/core/data_models/chit_template_datamodel.dart';
import 'package:vdo_chit_app/core/shared/ui/base_widget.dart';
import 'package:vdo_chit_app/core/shared/ui/widgets/widgets.dart';
import 'package:vdo_chit_app/locator.dart';
import 'package:vdo_chit_app/ui/base_model_widget.dart';
import 'package:vdo_chit_app/ui/chit_template_view.dart/chit_template_view_model.dart';

import '../preference_model.dart';

class ChitTemplateView extends StatelessWidget {
   const ChitTemplateView({ Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<ChitTemplateViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context){
            return Scaffold(
               backgroundColor: Provider.of<PreferenceModel>(context).theme.background,
               appBar: AppBar(
                  backgroundColor: Provider.of<PreferenceModel>(context).theme.primary,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.add, size: 30,), 
                        onPressed: ()=>{ Navigator.of(context).pushNamed('/addchittemplate') }
                     )
                  ],
                  title: Text(Provider.of<PreferenceModel>(context).language.appBarChitTemplate),
               ),
               body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: ChitTemplateList(),
               )
            );
         }
      );
   }
}

class ChitTemplateList extends BaseModelWidget<ChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, ChitTemplateViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chitTemplates.length,
         itemBuilder: (context, index){
            ChitTemplate chitTemplate = model.chitTemplates[index];
            return GestureDetector(
               onLongPress: (){
                  print("Long pressed show edit icons");
               },
               onTap: (){
                  print("Move to next screen");
               },
               child: CustomCard(
                  model: model,
                  child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                     child: Row(
                        children: [
                           Expanded( 
                              flex: 1, 
                              child: Cell(
                                 label: model.language.labelChitAmount, 
                                 value: chitTemplate.amount, 
                                 model: model
                              )
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelChitPercentage, 
                                 value: chitTemplate.percentage, 
                                 model: model,
                              ), 
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelChitTemplateMembersCount,
                                 value: chitTemplate.membersCount, 
                                 model: model,
                              ), 
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