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
   final ChitInfo chit;
   const AddChitView({ Key key, this.chit }) : super(key: key);

   @override
   _AddChitViewState createState() => _AddChitViewState();
}

class _AddChitViewState extends State<AddChitView> {

   TextEditingController _chitNameController, _chitDayController;
   List<Member> selectedMembers = [];
   ChitInfo chit;

   void fetchMembersOfChit(int chitId) async {
      List<Member> members = await locator<ChitViewModel>().getMembersOfChit(chitId);
      this.selectedMembers = members ?? [];
      setState(() {});
   }

   @override
   void initState() {
      _chitNameController = TextEditingController();
      _chitDayController = TextEditingController();
      chit = widget.chit;      
      if(chit != null){
         _chitNameController = TextEditingController(text: chit.name);
         _chitDayController = TextEditingController(text: chit.chitDay?.toString());
         fetchMembersOfChit(chit.id);
      }else{
         chit = ChitInfo();
      }
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
                  title: chit?.id != null ? Text(chit.name) : Text(model.language.appBarNewChit),
               ),
               body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                  child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        SizedBox(height: 10.0,),
                        SelectChitTemplate(onSelect: selectTemplate, chit: this.chit,),
                        ChitNameInputField(controller: _chitNameController,),
                        SizedBox(height: 10.0,),
                        ChitDateInputField(controller: _chitDayController,),
                        SizedBox(height: 10.0,),
                        
                        /// Selected chit member area
                        Expanded(child: chit?.id != null
                           ? SelectChitMembers(chitTemplate: chit.chitTemplate, members: chit.members, onSelect: selectMember, onSwitch: switchMember,)
                           : Center(child: Text("Create chit to add Members"))
                        ),
                        
                        /// ACTION BUTTONS
                        model.state == ViewState.Busy
                        ? Center(child: CupertinoActivityIndicator(),)
                        : ActionButtons(
                           chitInfo: chit,
                           onCancel: (){ Navigator.pop(context); },
                           onCreate: onCreate(model, chit, this._chitNameController, this._chitDayController, context),
                           onFinishLater: onFinishLater(model, context),
                           onUpdate: onUpdate(model, context),
                        ),
                        SizedBox(height: 10.0,),
                     ],
                  ),
               ),
            );
         },
      );
   }

   Function(
      ChitViewModel model, 
      ChitInfo chit, 
      TextEditingController nameController,
      TextEditingController dayController,
      BuildContext context) 
      onCreate = (
         ChitViewModel model, 
         ChitInfo chit, 
         TextEditingController nameController,
         TextEditingController dayController,
         BuildContext context){
      void create() async {
         print("Creating new chit ${model.language.buttonCreate} clicked");
         chit.setId(34);
         chit.setName(nameController.text);
         chit.setDay( num.tryParse(dayController.text));
         Future.delayed(Duration.zero, (){ model.setState(ViewState.Idle); });
         // Navigator.pop(context);
      }
      return create;
   };

   Function(ChitViewModel model, BuildContext context) onFinishLater = (ChitViewModel model, BuildContext context){
      void hello() async {
         print("Creating new chit ${model.language.buttonCreate} clicked");
         Navigator.pop(context);
      }
      return hello;
   };

   Function(ChitViewModel model, BuildContext context) onUpdate = (ChitViewModel model, BuildContext context){
      void hello() async {
         print("Creating new chit ${model.language.buttonCreate} clicked");
         Navigator.pop(context);
      }
      return hello;
   };

   void selectTemplate(ChitTemplate template, BaseModel model){
      chit.setChitTemplate(template);
      print("template selected");
      Future.delayed(Duration.zero, (){ model.setState(ViewState.Idle); });
   }

   void selectMember(Member member, BaseModel model){
      Member newMemberObj = Member.fromInstance(member);
      chit.addMember(newMemberObj);
      print("Member added ${chit.members.length}");
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
   final ChitInfo chit;
   
   SelectChitTemplate({ @required this.onSelect, @required this.chit });
   
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
            chit.chitTemplate == null 
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
               customCardGestures: CustomCardGestures( onTap: chit.id == null ? selectTemplate : null ),
               child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                     child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Expanded( 
                              flex: 1, 
                              child: Cell(
                                 label: model.language.labelChitAmount, 
                                 value: chit.chitTemplate.amount, 
                                 model: model,
                              )
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelChitPercentage, 
                                 value: chit.chitTemplate.percentage, 
                                 model: model,
                              ), 
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelChitTemplateMembersCount, 
                                 value: chit.chitTemplate.membersCount, 
                                 model: model,
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

      Function onMemberSwitched = (int indexToReplace) {
         Function switchMember = () async {
            dynamic obj = await Navigator.of(context).pushNamed("/selectchitmembers", arguments: { "index": indexToReplace });
            if(obj != null){
               onSwitch(obj, model);
            }
         };

         return switchMember;
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
                     : ListView.builder(    
                        itemCount: members.length,
                        itemBuilder: (builder, index){
                           Member member = members[index];
                           return CustomCard(          
                              customCardGestures: CustomCardGestures(
                                 onTap: onMemberSwitched(index)
                              ),
                              model: model,
                              child: Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                                 child: Row(
                                    children: [
                                       Expanded(child:Text(member.name+" ${member.aliasName != null && member.aliasName != '' ? "( "+member.aliasName+" )" : '' }")),
                                       Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Text(member.phone),
                                       ),
                                       Icon(Icons.phone_forwarded_rounded, size: 20.0,),
                                    ],
                                 ),
                              ),
                           );
                        }
                     )
            ),
         ],
      );
   }
}

class ActionButtons extends BaseModelWidget<ChitViewModel>{

   final ChitInfo chitInfo;
   final Function onCancel;
   final Function onCreate;
   final Function onFinishLater;
   final Function onUpdate;

   ActionButtons({ @required this.onCancel, @required this.onCreate, @required this.onFinishLater, @required this.onUpdate, @required this.chitInfo });

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
                  label: chitInfo?.id == null
                     ? model.language.buttonCreate
                     : chitInfo.members?.length == chitInfo.chitTemplate.membersCount
                        ? model.language.buttonUpdate
                        : model.language.buttonFinishLater,
                  onPressed: chitInfo?.id == null
                     ? onCreate
                     : chitInfo.members?.length == chitInfo.chitTemplate.membersCount
                        ? onUpdate
                        : onFinishLater,
               )
            ),
         ],
      );
   }
}

