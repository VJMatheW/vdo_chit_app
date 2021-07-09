import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdo_chit_app/ui/base_model.dart';

import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../core/shared/ui/widgets/widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'chit_view_model.dart';

class AddChitView extends StatefulWidget {
  const AddChitView({ Key key }) : super(key: key);

  @override
  _AddChitViewState createState() => _AddChitViewState();
}

class _AddChitViewState extends State<AddChitView> {

   TextEditingController _chitNameController, _chitDayController;
   ChitTemplate selectedTemplate;
   List<Member> selectedMembers = [];

   @override
   void initState() {
      _chitNameController = TextEditingController();
      _chitDayController = TextEditingController();
      super.initState();
   }

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<ChitViewModel>(),
         builder: (context, ChitViewModel model, child){
            return Scaffold(
               backgroundColor: model.theme.background,
               resizeToAvoidBottomInset: false,
               appBar: AppBar(
                  backgroundColor: model.theme.primary,
                  title: Text(model.language.appBarNewChit),
               ),
               body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                  child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        SizedBox(height: 10.0,),
                        SelectChitTemplate(onSelect: selectTemplate, chitTemplate: this.selectedTemplate,),
                        ChitNameInputField(controller: _chitNameController,),
                        SizedBox(height: 10.0,),
                        ChitDateInputField(controller: _chitDayController,),
                        SizedBox(height: 10.0,),
                        Expanded(child: SelectChitMembers(chitTemplate: this.selectedTemplate, members: this.selectedMembers, onSelect: selectMember, onSwitch: switchMember,)),
                        model.state == ViewState.Busy
                        ? Center(child: CupertinoActivityIndicator(),)
                        : ActionButtons(
                           onCancel: (){ Navigator.pop(context); },
                           onSuccess: () async {},
                        ),
                        SizedBox(height: 10.0,),
                     ],
                  ),
               ),
            );
         },
      );
   }

   void selectTemplate(ChitTemplate template, BaseModel model){
      this.selectedTemplate = template;
      print("template selected");
      Future.delayed(Duration.zero, (){ model.setState(ViewState.Idle); });
   }

   void selectMember(Member member, BaseModel model){
      this.selectedMembers.add(member);
      print("Member added");
      Future.delayed(Duration.zero, (){ model.setState(ViewState.Idle); });
   }

   void switchMember(Member member, BaseModel model){
      this.selectedMembers.add(member);
      print("Member added");
      Future.delayed(Duration.zero, (){ model.setState(ViewState.Idle); });
   }
}

class SelectChitTemplate extends BaseModelWidget<ChitViewModel>{
   final Function onSelect;
   final ChitTemplate chitTemplate;
   
   SelectChitTemplate({ @required this.onSelect, @required this.chitTemplate });
   
   @override
   Widget build(BuildContext context, ChitViewModel model) {

      Function selectTemplate = () async {
         dynamic chitTemplateSelected = await Navigator.of(context).pushNamed("/selectchittemplate");
         print("Template : $chitTemplateSelected");
         if(chitTemplateSelected != null){
            onSelect(chitTemplateSelected, model);
         }
      };

      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            /// Chit template label
            UIWidgets.textInputLabel(label: model.language.labelChitTemplate, model: model),

            /// Chit template
            chitTemplate == null 
            ? CustomCard(
               model: model,
               child: SizedBox(
                  height: 60, 
                  width: double.infinity,
                  child: TextButton(
                     onPressed: selectTemplate, 
                     child: Text(model.language.buttonSelectTemplateForChit),
                  ),
               ),
            )
            : CustomCard(
               model: model,
               customCardGestures: CustomCardGestures( onTap: selectTemplate ),
               child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                     child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Expanded( 
                              flex: 1, 
                              child: Cell(
                                 label: model.language.labelChitAmount, 
                                 value: chitTemplate.amount, 
                                 model: model,
                                 labelFontSize: 10.0,
                                 valueFontSize: 15.0,
                              )
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelChitPercentage, 
                                 value: chitTemplate.percentage, 
                                 model: model,
                                 labelFontSize: 10.0,
                                 valueFontSize: 15.0,
                              ), 
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelChitTemplateMembersCount, 
                                 value: chitTemplate.membersCount, 
                                 model: model,
                                 labelFontSize: 10.0,
                                 valueFontSize: 15.0,
                              ), 
                           ),
                        ],
                     ),
               ),
            )
         ],
      );
   }
}

class ChitNameInputField extends BaseModelWidget<ChitViewModel>{

   final TextEditingController controller;

   ChitNameInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelChitName, model: model),
            SizedBox(
               height: 35.0,
               child: UIWidgets.textInput(
                  context: context,
                  controller: controller, 
                  model: model,
                  hintText: model.language.hintChitName
               ),
            )
         ],
      );
   }
}

class ChitDateInputField extends BaseModelWidget<ChitViewModel>{

   final TextEditingController controller;

   ChitDateInputField({ @required this.controller });

   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelChitDate, model: model),
            SizedBox(
               height: 35.0,
               child: UIWidgets.textInput(
                  context: context,
                  controller: controller, 
                  model: model,
                  hintText: model.language.hintChitDate
               ),
            )
         ],
      );
   }
}

class SelectChitMembers extends BaseModelWidget<ChitViewModel>{

   final ChitTemplate chitTemplate;
   final List<Member> members;
   final Function onSelect;
   final Function onSwitch;

   SelectChitMembers({ @required this.chitTemplate, @required this.members, @required this.onSelect, @required this.onSwitch });

   @override
   Widget build(BuildContext context, ChitViewModel model) {

      Function onMemberSelected = () async {
         dynamic member = await Navigator.of(context).pushNamed("/selectchitmembers");
         if(member != null){
            onSelect(member, model);
         }
      };

      return Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
            /// label & count & icon
            Row(
               children: [
                  UIWidgets.textInputLabel(label: model.language.labelChitMembers, model: model),
                  Expanded(
                     child:   chitTemplate != null 
                        ? Text(" ( ${members.length}/${chitTemplate.membersCount} ) ")
                        : SizedBox.shrink()
                  ),

                  // showing caret-down icon only when member count is less 
                  chitTemplate != null
                  ? members.length < chitTemplate.membersCount
                     ? GestureDetector(
                        onTap: onMemberSelected,
                        child: Icon(Icons.arrow_drop_down, color: model.theme.primary, size: 30.0,)
                     )
                     : SizedBox.shrink()
                  : SizedBox.shrink()
               ],
            ),
            /// member list
            Expanded(
               child: chitTemplate == null
                  ? Center(child: Text("Select chit template to add members"),)
                  : members.length == 0
                     ? Center(
                        child: TextButton(
                           child: Text("+ Select members"),
                           onPressed: onMemberSelected,
                        ),)
                     : Center(child: Text("List of members"),)
            ),
         ],
      );
   }
}

class ActionButtons extends BaseModelWidget<ChitViewModel>{

   final Function onCancel;
   final Function onSuccess;

   ActionButtons({ @required this.onCancel, @required this.onSuccess });

   @override
   Widget build(BuildContext context, ChitViewModel model) {
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

