import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vdo_chit_app/core/shared/ui/base_widget.dart';
import 'package:vdo_chit_app/core/shared/ui/ui_widgets.dart';
import 'package:vdo_chit_app/locator.dart';
import 'package:vdo_chit_app/ui/add_chit_template_view.dart/add_chit_template_view_model.dart';
import 'package:vdo_chit_app/ui/preference_model.dart';

import '../base_model_widget.dart';

class AddChitTemplateView extends StatelessWidget {
  const AddChitTemplateView({ Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<AddChitTemplateViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context){
            return Container(
               margin: EdgeInsets.only(top: 200),
               child: SingleChildScrollView( // for bottom constraint
                  child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: 12),
                     child: Material(
                        child: Container(  // to fill in width 100%
                           width: double.infinity,
                           child: Stack(
                              children: [
                                 Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                       children: [                                    
                                          SizedBox(height: 30,),
                                          AddChitTemplateHeading(),
                                          SizedBox(height: 25,),
                                          ChitAmountInputField(),
                                          SizedBox(height: 20,),
                                          ChitPercentageInputField(),
                                          SizedBox(height: 20,),
                                          ChitMembersCountInputField(),
                                          SizedBox(height: 30,),
                                          ActionButtons(),
                                          SizedBox(height: 30,),
                                       ],                                   
                                    ),
                                 ),
                                 
                                 // Close button
                                 Positioned(
                                    right: 0,
                                    child: Transform(
                                       alignment: Alignment.center,
                                       transform: Matrix4.rotationZ(0.785398),
                                      child: IconButton(
                                         icon: Icon(
                                            Icons.add,
                                            color: Provider.of<PreferenceModel>(context).theme.primary,
                                            size: 30,
                                            ), 
                                         onPressed: (){ 
                                            Navigator.of(context).pop();
                                         },
                                      ),
                                    ),
                                 ),
                              ]
                           ),
                        ),
                     ),
                  ),
               ),
            );
         }
      );
   }
}

class AddChitTemplateHeading extends BaseModelWidget<AddChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, AddChitTemplateViewModel model) {
      return UIWidgets.modalHeading(model.language.modalHeadingAddChitTemplate, model);
   }
}

class ChitAmountInputField extends BaseModelWidget<AddChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, AddChitTemplateViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(context: context, label: model.language.labelChitValue, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintChitAmount,
                  inputType: TextInputType.number,
               ),
            )
         ],
      );
   }
}

class ChitPercentageInputField extends BaseModelWidget<AddChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, AddChitTemplateViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(context: context, label: model.language.labelChitPercentage, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintChitPercentage,
                  inputType: TextInputType.number,
               ),
            )
         ],
      );
   }
}

class ChitMembersCountInputField extends BaseModelWidget<AddChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, AddChitTemplateViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(context: context, label: model.language.labelChitMembersCount, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintChitMembersCount,
                  inputType: TextInputType.number    
               )
            )
         ],
      );
   }
}

class ActionButtons extends BaseModelWidget<AddChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, AddChitTemplateViewModel model) {
      return Row(
         children: [            
            Expanded(
               flex: 1,
               child: Padding(
                  padding: const EdgeInsets.only(right: 0.0, left: 30.0),
                  child: UIWidgets.buttonBasic(
                     model: model, 
                     context: context, 
                     label: model.language.buttonCancel,
                     onPressed: (){}
                  ),
               )
            ),
            SizedBox(width: 10,),
            Expanded(
               flex: 1,
               child: Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 0.0),
                  child: UIWidgets.buttonSuccess(
                     model: model, 
                     context: context, 
                     label: model.language.buttonCreate,
                     onPressed: (){}
                  ),
               )
            ),
         ],
      );
   }
}

class ConstrainedView extends StatelessWidget{
   ConstrainedView({
      Key key,
      @required this.child,
      this.width = 250.0
   }) : super(key : key);

   final Widget child;
   final double width; 
   
   @override
   Widget build(BuildContext context) {
      return LayoutBuilder(
         builder: (context, constraints){
            if(constraints.maxWidth < width || constraints.maxHeight < 300){
               return const Text('');
            }
            return child;
         }
      );  
   }

}