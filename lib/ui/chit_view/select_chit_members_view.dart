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
   final data;
   const SelectChitMembersView({ Key key, this.data }) : super(key: key);

   @override
   _SelectChitMembersViewState createState() => _SelectChitMembersViewState();
}

class _SelectChitMembersViewState extends State<SelectChitMembersView> {

   TextEditingController _searchMemberController;
   TextEditingController _aliasNameController;
   Member selectedMember;
   Member memberToBeReplaced;
   int indexToReplace;
   int chitId;

   @override
   void initState() {
      _searchMemberController = TextEditingController();
      _aliasNameController = TextEditingController(text: '');

      if(widget.data["mode"] == "replace"){
         indexToReplace = widget.data["indexToReplace"];
         memberToBeReplaced = widget.data["member"];
         chitId = widget.data["chitId"];
      }

      if(widget.data["mode"] == "add"){
         chitId = widget.data["chitId"];
      }

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
                                    Expanded(
                                       flex: 0,
                                       child: model.state == ViewState.Busy
                                          ? Center(child: CupertinoActivityIndicator(),)
                                          : UIWidgets.buttonSuccess(
                                             context: context, 
                                             label: model.language.buttonSelect,
                                             model: model,
                                             onPressed: () async {
                                                if(selectedMember != null){
                                                   selectedMember.setAliasName(_aliasNameController.text);

                                                   Map<String, dynamic> chitMember;

                                                   // hit add api or update chit member API
                                                   if(memberToBeReplaced == null){
                                                      // invoke add api
                                                      chitMember = await model.addChitMember(chitId, selectedMember);
                                                   }else{
                                                      // invoke update api
                                                      chitMember = await model.replaceChitMember(chitId, selectedMember, memberToBeReplaced);
                                                   }
                                                   
                                                   if(chitMember != null){
                                                      print(selectedMember);
                                                      // caching locally
                                                      selectedMember.setChitMemberId(chitMember["id"]);
                                                      Map<String, dynamic> obj = {
                                                            "mode": widget.data["mode"],
                                                            "member": selectedMember,
                                                            "indexToReplace": indexToReplace
                                                      };
                                                      
                                                      Navigator.of(context).pop(obj);
                                                   }
                                                }
                                             }
                                          ),
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