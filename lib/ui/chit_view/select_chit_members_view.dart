import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../core/shared/ui/widgets/custom_card.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'chit_view_model.dart';

class SelectChitMembersView extends StatefulWidget {
   const SelectChitMembersView({ Key key }) : super(key: key);

   @override
   _SelectChitMembersViewState createState() => _SelectChitMembersViewState();
}

class _SelectChitMembersViewState extends State<SelectChitMembersView> {

   TextEditingController _searchMemberController;
   TextEditingController _aliasNameController;
   Member selectedMember;

   @override
   void initState() {
      _searchMemberController = TextEditingController();
      _aliasNameController = TextEditingController(text: '');
      locator<ChitViewModel>().getMembers();
      super.initState();
   }

   @override
   void dispose() {
      _searchMemberController.dispose();
      _aliasNameController.dispose();
      super.dispose();
   }

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
                     padding: EdgeInsets.only(bottom: 10.0),
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
                                 children: [
                                    SizedBox(height: 35, width: double.infinity,),
                                    /// heading and member search
                                    Row(
                                       children: [
                                          UIWidgets.labelHeading("Select Members", model),
                                          Expanded(
                                             child: Padding(
                                                padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 100) * 10),
                                                child: SizedBox(
                                                   height: 30.0,
                                                   child: UIWidgets.textInputWithPrefixIcon(
                                                      context: context,
                                                      hintText: model.language.hintDashboardSearchMember,
                                                      controller: _searchMemberController,
                                                      model: model,
                                                      prefixIcon: Icons.search,
                                                   ),
                                                ),
                                             ),
                                          ),                                          
                                       ],
                                    ),

                                    /// Members list
                                    Expanded(
                                       flex: 1,
                                       child: model.state == ViewState.Busy
                                          ? Center(child: CupertinoActivityIndicator(),)
                                          : MemberList(onAdd: onAdd,)
                                    ),

                                    /// Member alias input
                                    MemberAliasName(controller: _aliasNameController),
                                    SizedBox(height: 5.0,),

                                    /// Select button
                                    UIWidgets.buttonSuccess(
                                       context: context, 
                                       label: model.language.buttonSelect,
                                       model: model,
                                       onPressed: (){
                                          if(selectedMember != null){
                                             /// select button
                                             Map<String, dynamic> obj = {
                                                "member": selectedMember,
                                                "aliasName": _aliasNameController.text
                                             };
                                             selectedMember.setAliasName(_aliasNameController.text);
                                             Navigator.of(context).pop(selectedMember);
                                          }
                                       }
                                    ),
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

   void onAdd(Member member){
      if(member != null){
         this.selectedMember = member;
      }
   }
}

class MemberList extends BaseModelWidget<ChitViewModel>{

   final Function onAdd;

   MemberList({ @required this.onAdd });

   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return ListView.builder(
         physics: BouncingScrollPhysics(),
         itemCount: model.members.length,
         itemBuilder: (context, index){    
            Member member = model.members[index];
            return CustomCard(   
               color: member.selected ? Colors.blue[100] : null,            
               customCardGestures: CustomCardGestures(
                  onTap: (){ 
                     model.markMemberAsSelected(member); 
                     onAdd(member);
                  },
               ),
               model: model,
               child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                     children: [
                        Expanded(child:Text(member.name)),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(member.phone),
                        ),
                        Icon(Icons.phone_forwarded_rounded, size: 20.0,),
                     ],
                  ),
               ),
            );
         },
      );
   }
}

class MemberAliasName extends BaseModelWidget<ChitViewModel>{

   final TextEditingController controller;

   MemberAliasName({ @required this.controller });

   @override
   Widget build(BuildContext context, ChitViewModel model) {
      return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            UIWidgets.textInputLabel(label: model.language.labelMemberAliasName, model: model),
            Container(
               height: 30.0,
               child: UIWidgets.textInput(
                  context: context, 
                  model: model, 
                  hintText: model.language.hintMemberAliasName,
                  inputType: TextInputType.text,
                  controller: controller,
               ),
            )
         ],
      );
   }
}