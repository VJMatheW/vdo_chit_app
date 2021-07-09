import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/data_models/chit_template_datamodel.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../core/shared/ui/widgets/custom_card.dart';
import '../../core/shared/ui/widgets/widgets.dart';
import '../base_model_widget.dart';

import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../locator.dart';
import 'chit_view_model.dart';

class SelectChitTemplateView extends StatelessWidget {
  const SelectChitTemplateView({ Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<ChitViewModel>(),
         onModelReady: (ChitViewModel model)=> model.getChitTemplates(),
         builder: (context, ChitViewModel model, child){
            return Material(
               color: Colors.transparent,
               child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                     padding: EdgeInsets.only(bottom: 15.0),
                     height: (MediaQuery.of(context).size.height / 100) * 65,
                     margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 100) * 15,
                        left: 12.0,
                        right: 12.0,
                     ),
                     color: model.theme.background,
                     child: Stack(
                        children: [
                           /// CLOSE BUTTON
                           model.state == ViewState.Busy
                           ? SizedBox.shrink()
                           : Positioned(
                              right: 0,
                              top: 0,
                              child: Transform(
                                 alignment: Alignment.center,
                                 transform: Matrix4.rotationZ( 0.785398)..translate(0.0, -7.0, 3.0),
                                 child: IconButton(
                                    icon: Icon(
                                       Icons.add,
                                       color: model.theme.primary,
                                       size: 30,
                                    ),
                                    onPressed: (){ 
                                       Navigator.of(context).pop();
                                    },
                                 ),
                              ),
                           ),
                           /// Popup content
                           Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                 // mainAxisSize: MainAxisSize.max,
                                 children: [
                                    SizedBox(height: 35, width: double.infinity,),
                                    ChooseChitTemplateHeading(),
                                    Expanded(
                                       flex: 1,
                                       child: model.state == ViewState.Busy
                                          ? Center(child: CupertinoActivityIndicator(),)
                                          : ChitTemplateList()
                                    ),
                                    // Expanded(child: ChitTemplateList()),
                                    // ,
                                 ],
                              ),
                           )
                        ],
                     ),
                  ),  
               ),
            );
         },
      );
   }
}

class ChooseChitTemplateHeading extends BaseModelWidget<ChitViewModel>{
   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return UIWidgets.modalHeading(model.language.modalHeadingChooseChitTemplate, model);
   }
}

class ChitTemplateList extends BaseModelWidget<ChitViewModel>{
   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 15.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chitTemplates.length,
         itemBuilder: (context, index){
            ChitTemplate chitTemplate = model.chitTemplates[index];
            return CustomCard(
               bottomMargin: 10.0,
               model: model,
               customCardGestures: CustomCardGestures(
                  onTap: (){
                     Navigator.of(context).pop(chitTemplate);
                  }
               ),
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Row(
                    children: [
                       Expanded( 
                          flex: 1, 
                          child: Cell(
                             label: model.language.labelChitAmount, 
                             value: chitTemplate.amount, 
                             model: model,
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
            );
         },

      );
   }

}