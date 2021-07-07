import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'member_view_model.dart';

class AddMemberView extends StatefulWidget {
   const AddMemberView({ Key key }) : super(key: key);

  @override
  _AddMemberViewState createState() => _AddMemberViewState();
}

class _AddMemberViewState extends State<AddMemberView> {

   TextEditingController _nameController, _phoneController;

   @override
   void initState() {
      _nameController = TextEditingController();
      _phoneController = TextEditingController();
      super.initState();
   }

   @override
   void dispose() {
      _nameController.dispose();
      _phoneController.dispose();
      super.dispose();
   }

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<MemberViewModel>(),
         builder: (context, MemberViewModel model, child){
            return Material(
               color: Colors.transparent,
               child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                     margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height / 100) * 15,
                        left: 12,
                        right: 12
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
                                       AddMemberHeading(),
                                       SizedBox(height: 25,),
                                       MemberNameInputField( controller: _nameController ),
                                       SizedBox(height: 20,),
                                       MemberPhoneInputField( controller: _phoneController ),
                                       SizedBox(height: 30,),
                                       model.state == ViewState.Busy
                                       ? Center(child: CupertinoActivityIndicator(),)
                                       : ActionButtons(
                                          onCancel: (){
                                             Navigator.pop(context);
                                          },
                                          onSuccess: () async {
                                             String name = _nameController.text;
                                             String phone = _phoneController.text;

                                             bool status = await model.postMember(name, phone);
                                             
                                             if(status){
                                                Navigator.pop(context);
                                             }
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
         },
      );
   }
}

class AddMemberHeading extends BaseModelWidget<MemberViewModel>{
   @override
   Widget build(BuildContext context, MemberViewModel model) {
      return UIWidgets.modalHeading(model.language.modalHedingNewMember, model);
   }
}

class MemberNameInputField extends BaseModelWidget<MemberViewModel>{

   final TextEditingController controller;

   MemberNameInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, MemberViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelMemberName, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintMemberName,
                  inputType: TextInputType.text,
                  controller: controller,
               ),
            )
         ],
      );
   }
}

class MemberPhoneInputField extends BaseModelWidget<MemberViewModel>{

   final TextEditingController controller;

   MemberPhoneInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, MemberViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelMemberPhone, model: model),
            Container(
               height: 43.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintMemberPhone,
                  inputType: TextInputType.number,
                  controller: controller,
               ),
            )
         ],
      );
   }
}

class ActionButtons extends BaseModelWidget<MemberViewModel>{

   final Function onCancel;
   final Function onSuccess;

   ActionButtons({ @required this.onCancel, @required this.onSuccess });

   @override
   Widget build(BuildContext context, MemberViewModel model) {
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