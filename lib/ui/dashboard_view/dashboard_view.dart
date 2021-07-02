import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/data_models/data_models.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../core/shared/ui/widgets/widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import '../preference_model.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatefulWidget {

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin {
   bool toggle = true;

   AnimationController animationController;
   Animation btnChitConfigAnimation, btnMemberAnimation, btnChitAnimation;

   Animation rotationAnimation;

   double getRadianFromDegree(double degree){
      double unitRadian = 57.295779513;
      return degree/unitRadian;
   }

   @override
   void initState() {   
      animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
      
      btnChitConfigAnimation = TweenSequence([
         TweenSequenceItem(tween: Tween<double>(begin: 0.1, end: 1.4), weight: 75),
         TweenSequenceItem(tween: Tween<double>(begin: 1.4, end: 1.0), weight: 25)
      ]).animate(animationController);
      btnMemberAnimation = TweenSequence([
         TweenSequenceItem(tween: Tween<double>(begin: 0.1, end: 1.4), weight: 55),
         TweenSequenceItem(tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45)
      ]).animate(animationController);
      btnChitAnimation = TweenSequence([
         TweenSequenceItem(tween: Tween<double>(begin: 0.1, end: 1.4), weight: 35),
         TweenSequenceItem(tween: Tween<double>(begin: 1.4, end: 1.0), weight: 65)
      ]).animate(animationController);

      rotationAnimation = Tween<double>(begin: 180, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

      animationController.addListener(() { setState(() { }); });
      super.initState();
   }

   @override
   void dispose() {
       animationController.dispose();
       super.dispose();
     }

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<DashboardViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context){
            return Scaffold(
               backgroundColor: Provider.of<PreferenceModel>(context).theme.background,
               appBar: AppBar(
                  backgroundColor: Provider.of<PreferenceModel>(context).theme.primary,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.settings), 
                        onPressed: (){ print("open up settings"); }
                     )
                  ],
                  title: Text("Organisation name"),
               ),
               body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [             
                     // search bar   
                     DashboardSearch(controller: new TextEditingController(),),
                     
                     // heading
                     DashboardHeading(),
                     
                     // DASHBOARD CARD LIST
                     Expanded( 
                        flex: 1, 
                        child: Stack(
                           clipBehavior: Clip.none,
                           children: <Widget>[
                              DashboardChitList(),
                              Positioned(
                                 // the width and height is given because flutter has issues with transform.translate
                                 // https://github.com/flutter/flutter/issues/27587#issuecomment-482814804
                                 width: 125 , // btnChitConfigAnimation.value * 125 > 50 ? btnChitConfigAnimation.value * 125 : 50,
                                 height: 125, // btnChitConfigAnimation.value * 125 > 50 ? btnChitConfigAnimation.value * 125 : 50,
                                 bottom: 20,
                                 right: 20,
                                 child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                       Transform.translate(
                                          offset: Offset.fromDirection(getRadianFromDegree(184), btnChitAnimation.value * 80),
                                          child: Transform(
                                             alignment: Alignment.center,
                                             transform: Matrix4.rotationZ(getRadianFromDegree(rotationAnimation.value))..scale(btnChitAnimation.value),
                                             child: CircularButton(
                                                width: 40,
                                                height: 40,
                                                color: Colors.white,
                                                icon: Icon(Icons.file_copy),
                                                onClick: ()=>{ print('add chit clicked') },
                                             ),
                                          ),
                                       ),
                                       Transform.translate(
                                          offset: Offset.fromDirection(getRadianFromDegree(223), btnMemberAnimation.value * 80),
                                          child: Transform(
                                             alignment: Alignment.center,
                                             transform: Matrix4.rotationZ(getRadianFromDegree(rotationAnimation.value))..scale(btnMemberAnimation.value),
                                             child: CircularButton(
                                                width: 40,
                                                height: 40,
                                                color: Colors.purple,
                                                icon: Icon(Icons.person_add),
                                                onClick: ()=>{ print('add member clicked') },
                                             ),
                                          ),
                                       ),
                                       Transform.translate(
                                          offset: Offset.fromDirection(getRadianFromDegree(265), btnChitConfigAnimation.value * 80),
                                          child: Transform(
                                             alignment: Alignment.center,
                                             transform: Matrix4.rotationZ(getRadianFromDegree(rotationAnimation.value))..scale(btnChitConfigAnimation.value),
                                             child: CircularButton(
                                                width: 40,
                                                height: 40,
                                                color: Colors.orange,
                                                icon: Icon(Icons.settings),
                                                onClick: (){ 
                                                   print('add chit config clicked');
                                                   animationController.reverse();
                                                   Navigator.pushNamed(context, "/chittemplate");
                                                },
                                             ),
                                          ),
                                       ),
                                       CircularButton(
                                          width: 50,
                                          height: 50,
                                          color: Colors.red,
                                          icon: Icon(Icons.add),
                                          onClick: (){ 
                                             if(animationController.isCompleted){
                                                animationController.reverse();
                                             }else{
                                                animationController.forward();
                                             }
                                          },
                                       )
                                    ],
                                 )
                              )
                           ]
                        )
                     )
                  ],
               )
            ); 
         } // builder function
      );
   }
}

class DashboardSearch extends BaseModelWidget<DashboardViewModel>{
   final TextEditingController controller;
   DashboardSearch({ @required this.controller});
   @override
   Widget build(BuildContext context, DashboardViewModel model){
      return Padding(
         padding: const EdgeInsets.only( left: 12.0, right: 12.0, top: 20.0),
         child: Container(
            height: 40.0,
           child: UIWidgets.textInputWithPrefixIcon(
              context: context,
              hintText: model.language.hintDashboardSearchMember,
              controller: controller,
              model: model,
              prefixIcon: Icons.search,
           ),
         )
      );
   }
}

class DashboardHeading extends BaseModelWidget<DashboardViewModel>{
   @override
   Widget build(BuildContext context, DashboardViewModel model){
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
         child: UIWidgets.heading(model.language.headingOngoingChits, model)
      );
   }
}

class DashboardChitList extends BaseModelWidget<DashboardViewModel> {

   @override
   Widget build(BuildContext context, DashboardViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chitsInfo.length,
         itemBuilder: (context, index){
            ChitInfo chitInfo = model.chitsInfo[index];
            return GestureDetector(
               onLongPress: (){
                  print("Long pressed show edit icons");
               },
               onTap: (){
                  print("Move to next screen");
               },
               child: CustomCard(
                  // margin: EdgeInsets.only(bottom: 15.0),
                  // elevation: 3.0,
                  child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                     child: Column(
                        children: [

                              // ROW 1
                              Row(
                                 children: [
                                    Expanded( 
                                       flex: 1, 
                                       child: Cell(
                                          label: model.language.lableChitName, 
                                          value: chitInfo.name, 
                                          model: model
                                       )
                                    ),
                                    Expanded(
                                       flex: 1,
                                       child: Cell(
                                          label: model.language.labelChitValue, 
                                          value: chitInfo.chitTemplate.amount, 
                                          model: model,
                                       ), 
                                    ),
                                 ],
                              ),
                              SizedBox(height: 15.0,),
                              
                              // ROW 2
                              Row(
                                 children: [
                                    Expanded( 
                                       flex: 1, 
                                       child: Cell(
                                          label: model.language.labelInstallmentNo, 
                                          value: chitInfo.installments[0].installmentNo, 
                                          model: model,
                                       ),
                                    ),
                                    Expanded(
                                       flex: 1,
                                       child: Cell(
                                          label: model.language.labelMembers, 
                                          value: chitInfo.chitTemplate.membersCount, 
                                          icon: Icons.supervisor_account, model: model,
                                       ),
                                    ),
                                 ],
                              ),

                              SizedBox(height: 15.0,),
                              
                              // ROW 3
                              Row(
                                 children: [
                                    Expanded(
                                       flex: 1,
                                       child: Cell(
                                          label: model.language.labelChitDate, 
                                          value: chitInfo.chitDay, 
                                          model: model,
                                       ),
                                    ),
                                    Expanded( 
                                       flex: 1, 
                                       child: Cell(
                                          label: model.language.labelPayableAmount, 
                                          value: chitInfo.installments[0].payableAmount, 
                                          model: model,
                                       ),
                                    ),
                                 ],
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