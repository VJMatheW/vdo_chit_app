import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/widgets/widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'member_view_model.dart';

class MemberView extends StatelessWidget {
  const MemberView({ Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<MemberViewModel>(),
         onModelReady: (model) => model.init(),
         builder: (context, MemberViewModel model, child){
            return Scaffold(
               backgroundColor: model.theme.background,
               appBar: AppBar(
                  backgroundColor: model.theme.primary,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.add, size: 30,), 
                        onPressed: ()=>{ Navigator.of(context).pushNamed('/addmember') }
                     )
                  ],
                  title: Text(model.language.appBarMember),
               ),
               body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: model.state == ViewState.Busy
                     ? Center(child: CupertinoActivityIndicator(),)
                     : MemberList(),
               ),
            );
         },
      );
   }
}

class MemberList extends BaseModelWidget<MemberViewModel>{
   @override
   Widget build(BuildContext context, MemberViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.members.length,
         itemBuilder: (context, index){
            Member member = model.members[index];
            return GestureDetector(
               onLongPress: (){
                  print("Long pressed show edit icons");
               },               
               child: CustomCard(
                  model: model,
                  customCardGestures: CustomCardGestures(
                     onTap: (){
                        print("Move to next screen");
                     },
                  ),
                  child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                     child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Expanded( 
                              flex: 1, 
                              child: Cell(
                                 label: model.language.labelMemberName, 
                                 value: member.name, 
                                 model: model
                              )
                           ),
                           Expanded(
                              flex: 1,
                              child: Cell(
                                 label: model.language.labelMemberPhone, 
                                 value: member.phone, 
                                 model: model,
                                 isPhoneNumber: true,
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