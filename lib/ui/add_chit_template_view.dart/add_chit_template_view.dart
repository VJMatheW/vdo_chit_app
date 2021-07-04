import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import '../preference_model.dart';
import 'add_chit_template_view_model.dart';

class AddChitTemplateView extends StatefulWidget {
  const AddChitTemplateView({ Key key }) : super(key: key);

  @override
  _AddChitTemplateViewState createState() => _AddChitTemplateViewState();
}

class _AddChitTemplateViewState extends State<AddChitTemplateView> {

   TextEditingController _amountController, _percentageController, _memberCountController;

   @override
   void initState(){
      _amountController = TextEditingController();
      _percentageController = TextEditingController();
      _memberCountController = TextEditingController();
      super.initState();
   }

   @override
   void dispose() {
      _amountController.dispose();
      _percentageController.dispose();
      _memberCountController.dispose();
      super.dispose();
   }

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<AddChitTemplateViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context){
            return Material(
               color: Colors.transparent,
               child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                     margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 100) * 15,
                        left: 12,
                        right: 12,
                     ),
                     color: Colors.white,
                     child: SingleChildScrollView(
                        child: Stack(
                           children: [
                              Positioned(
                                 right: 0,
                                 top: 0,
                                 child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationZ( 0.785398)..translate(0.0, -7.0, 3.0),
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
                              Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                 child: Column(
                                    mainAxisSize: MainAxisSize.min,
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
                              )
                           ]
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
               child: UIWidgets.buttonBasic(
                  model: model, 
                  context: context, 
                  label: model.language.buttonCancel,
                  onPressed: (){}
               )
            ),
            SizedBox(width: 10,),
            Expanded(
               flex: 1,
               child: UIWidgets.buttonSuccess(
                  model: model, 
                  context: context, 
                  label: model.language.buttonCreate,
                  onPressed: (){}
               )
            ),
         ],
      );
   }
}