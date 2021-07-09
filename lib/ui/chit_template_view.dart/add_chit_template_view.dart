import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'chit_template_view_model.dart';

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
         viewModel: locator<ChitTemplateViewModel>(),
         builder: (context, ChitTemplateViewModel model, child){
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
                     color: model.theme.background,
                     child: SingleChildScrollView(
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
                              Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                 child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [                                                        
                                       SizedBox(height: 30,),
                                       AddChitTemplateHeading(),
                                       SizedBox(height: 25,),
                                       ChitAmountInputField( controller: _amountController ),
                                       SizedBox(height: 20,),
                                       ChitPercentageInputField( controller: _percentageController ),
                                       SizedBox(height: 20,),
                                       ChitMembersCountInputField( controller: _memberCountController ),
                                       SizedBox(height: 30,),
                                       model.state == ViewState.Busy
                                       ? Center(child: CupertinoActivityIndicator(),)
                                       : ActionButtons(
                                          onCancel: (){
                                             Navigator.pop(context);
                                          },
                                          onSuccess: () async {
                                             String amount = _amountController.text;
                                             String percentage = _percentageController.text;
                                             String memberCount = _memberCountController.text;
                                             
                                             await model.postChitTemplate(amount, percentage, memberCount);

                                             Navigator.pop(context);
                                          },
                                       ),
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

class AddChitTemplateHeading extends BaseModelWidget<ChitTemplateViewModel>{
   @override
   Widget build(BuildContext context, ChitTemplateViewModel model) {
      return UIWidgets.modalHeading(model.language.modalHeadingAddChitTemplate, model);
   }
}

class ChitAmountInputField extends BaseModelWidget<ChitTemplateViewModel>{

   final TextEditingController controller;

   ChitAmountInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, ChitTemplateViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelChitValue, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintChitAmount,
                  inputType: TextInputType.number,
                  controller: controller,
               ),
            )
         ],
      );
   }
}

class ChitPercentageInputField extends BaseModelWidget<ChitTemplateViewModel>{

   final TextEditingController controller;

   ChitPercentageInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, ChitTemplateViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelChitPercentage, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintChitPercentage,
                  inputType: TextInputType.number,
                  controller: controller,
               ),
            )
         ],
      );
   }
}

class ChitMembersCountInputField extends BaseModelWidget<ChitTemplateViewModel>{

   final TextEditingController controller;

   ChitMembersCountInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, ChitTemplateViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelChitMembersCount, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintChitMembersCount,
                  inputType: TextInputType.number,
                  controller: controller,    
               )
            )
         ],
      );
   }
}

class ActionButtons extends BaseModelWidget<ChitTemplateViewModel>{

   final Function onCancel;
   final Function onSuccess;

   ActionButtons({ @required this.onCancel, @required this.onSuccess });

   @override
   Widget build(BuildContext context, ChitTemplateViewModel model) {
      return Row(
         children: [            
            Expanded(
               flex: 1,
               child: UIWidgets.buttonBasic(
                  model: model, 
                  context: context, 
                  label: model.language.buttonCancel,
                  onPressed: onCancel
               )
            ),
            SizedBox(width: 10,),
            Expanded(
               flex: 1,
               child: UIWidgets.buttonSuccess(
                  model: model, 
                  context: context, 
                  label: model.language.buttonCreate,
                  onPressed: onSuccess
               )
            ),
         ],
      );
   }
}