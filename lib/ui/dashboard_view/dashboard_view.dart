import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../core/data_models/data_models.dart';
import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../core/shared/ui/widgets/widgets.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatefulWidget {

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin {
   bool toggle = false;

   AnimationController animationController;
   Animation btnChitConfigAnimation, btnMemberAnimation, btnChitAnimation;
   Animation opacityAnimation;
   Animation rotationAnimation;

   TextEditingController memberSearchController;

   DashboardViewModel dashboardViewModel = locator<DashboardViewModel>();

   /// search member overlay - req
   final GlobalKey memberSearchKey = GlobalKey();
   Size searchMemberSize;
   Offset searchMemberPosition;   
   List<Member> suggestedMembers = [];
   bool showAutocomplete = false;

   double getRadianFromDegree(double degree){
      double unitRadian = 57.295779513;
      return degree/unitRadian;
   }

   // used for overlay autocomplete
   void calculateSizeAndPositionOfMemberSearch(GlobalKey key){
      WidgetsBinding.instance.addPostFrameCallback((_){ 
         final RenderBox box = key.currentContext.findRenderObject();
         searchMemberPosition = box.localToGlobal(Offset.zero);
         searchMemberSize = box.size;
      });
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
      opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

      animationController.addListener(() { setState(() { }); });

      // get and set position and size of search container for autocomplete
      calculateSizeAndPositionOfMemberSearch(memberSearchKey);

      /// member search text controller 
      memberSearchController = TextEditingController();
      memberSearchController.addListener((){         
         String query = memberSearchController.text;
         /// when search text is empty,
         /// hide overlay
         if(query == ""){
            setState(() { showAutocomplete = false; });
            return;
         }

         /// when search text is not empty, show overlay
         suggestedMembers = dashboardViewModel.searchMember(query);
         if(dashboardViewModel.suggestedMembers.length > 0){
            if(overlayEntries.length > 0){
               overlayEntries[0].markNeedsBuild();
            }
            setState(() { showAutocomplete = true; });
         }else{
            setState(() { showAutocomplete = false; });
         }
      });

      super.initState();
   }

   @override
   void dispose() {
      animationController.dispose();
      memberSearchController.dispose();
      super.dispose();
   }

   OverlayEntry overlayEntry;
   OverlayState overlayState;
   List<OverlayEntry> overlayEntries = [];

   @override
   Widget build(BuildContext context) {
      /// set up search autocomplete
      setUpSearchMemberAutoComplete(context);

      /// actual dashboard view 
      return BaseWidget(
         viewModel: locator<DashboardViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context, DashboardViewModel model, child){
            return Scaffold(
               backgroundColor: model.theme.background,
               appBar: AppBar(
                  backgroundColor: model.theme.primary,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.language), 
                        onPressed: (){ 
                           if(toggle){
                              model.setEnglishLanguage();
                              toggle = false;
                           }else{
                              model.setTamilLanguage();
                              toggle = true;
                           }
                        }
                     )
                  ],
                  title: Text("Organisation name"),
               ),
               body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [             
                     // search bar   
                     DashboardSearch(
                        controller: memberSearchController, 
                        memberSearchkey: memberSearchKey
                     ),
                     
                     // heading
                     DashboardHeading(),
                     
                     // DASHBOARD CARD LIST
                     Expanded( 
                        flex: 1, 
                        child: model.state == ViewState.Busy 
                        ? Center(child: CupertinoActivityIndicator())
                        : Stack(
                           // clipBehavior: Clip.none,
                           children: <Widget>[
                              // List
                              DashboardChitList(dashboardDispose: dashboardDispose ),

                              // Custom FAB button
                              Positioned(
                                 // the width and height is given because flutter has issues with transform.translate
                                 // https://github.com/flutter/flutter/issues/27587#issuecomment-482814804
                                 width: 100 , // btnChitConfigAnimation.value * 125 > 50 ? btnChitConfigAnimation.value * 125 : 50,
                                 height: MediaQuery.of(context).size.height, // btnChitConfigAnimation.value * 125 > 50 ? btnChitConfigAnimation.value * 125 : 50,
                                 bottom: 20,
                                 right: 20,
                                 child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                       Transform.translate(
                                          offset: Offset.fromDirection(getRadianFromDegree(268), btnChitAnimation.value * 190),
                                          child: Stack(
                                             clipBehavior: Clip.none,
                                             alignment: Alignment.bottomCenter,                                             
                                             children: [
                                                /// ADD CHIT BUTTON label
                                                Positioned(
                                                   bottom: -15.0,
                                                   child: opacityAnimation.value != 1.0 ? SizedBox.shrink() : Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(3.0),
                                                         color: model.theme.primary,
                                                      ),
                                                      child: Text(model.language.appBarChit, 
                                                         textAlign: TextAlign.center,
                                                         style: TextStyle(
                                                            color: model.theme.white,      
                                                            fontSize: opacityAnimation.value * 7,
                                                            fontWeight: FontWeight.bold,
                                                         ),
                                                      ),
                                                   )
                                                ),
                                                /// ADD CHIT BUTTON
                                                Transform(
                                                   alignment: Alignment.center,
                                                   transform: Matrix4.rotationZ(getRadianFromDegree(rotationAnimation.value))..scale(btnChitAnimation.value),
                                                   child: CircularButton(
                                                      width: 40,
                                                      height: 40,
                                                      color: model.theme.primary,
                                                      icon: Icon(Icons.file_copy, color: Colors.white,),
                                                      onClick: (){ 
                                                         dashboardDispose();
                                                         Navigator.pushNamed(context, "/chit");
                                                      },
                                                   ),
                                                ),
                                             ],
                                          ),
                                       ),
                                       Transform.translate(
                                          offset: Offset.fromDirection(getRadianFromDegree(267), btnMemberAnimation.value * 130),
                                          child: Stack(
                                             clipBehavior: Clip.none,
                                             alignment: Alignment.bottomCenter,
                                             children: [
                                                /// ADD MEMBER BUTTON label
                                                Positioned(
                                                   bottom: -15.0,
                                                   child: opacityAnimation.value != 1.0 ? SizedBox.shrink() : Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(3.0),
                                                         color: model.theme.primary,
                                                      ),
                                                      child: Text(model.language.appBarMember, 
                                                         textAlign: TextAlign.center,
                                                         style: TextStyle(
                                                            color: model.theme.white,      
                                                            fontSize: opacityAnimation.value * 7,
                                                            fontWeight: FontWeight.bold,
                                                         ),
                                                      ),
                                                   )
                                                ),
                                                /// ADD MEMBER BUTTON
                                                Transform(
                                                   alignment: Alignment.center,
                                                   transform: Matrix4.rotationZ(getRadianFromDegree(rotationAnimation.value))..scale(btnMemberAnimation.value),
                                                   child: CircularButton(
                                                      width: 40,
                                                      height: 40,
                                                      color: model.theme.primary,
                                                      icon: Icon(Icons.person_add, color: Colors.white,),
                                                      onClick: (){ 
                                                         dashboardDispose();
                                                         Navigator.pushNamed(context, "/member");
                                                      },
                                                   ),
                                                ),
                                             ],
                                          ),
                                       ),
                                       Transform.translate(
                                          offset: Offset.fromDirection(getRadianFromDegree(265), btnChitConfigAnimation.value * 70),
                                          child: Stack( 
                                             clipBehavior: Clip.none,
                                             alignment: Alignment.bottomCenter,
                                             children: [
                                                /// ADD CHIT TEMPLATE BUTTON label
                                                Positioned(
                                                   bottom: -15.0,
                                                   child: opacityAnimation.value != 1.0 ? SizedBox.shrink() : Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                      decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.circular(3.0),
                                                         color: model.theme.primary,
                                                      ),
                                                      child: Text(model.language.appBarChitTemplate, 
                                                         textAlign: TextAlign.center,
                                                         style: TextStyle(
                                                            color: model.theme.white,      
                                                            fontSize: opacityAnimation.value * 7,
                                                            fontWeight: FontWeight.bold,
                                                         ),
                                                      ),
                                                   )
                                                ),
                                                /// ADD CHIT TEMPLATE BUTTON
                                                Transform(
                                                   alignment: Alignment.center,
                                                   transform: Matrix4.rotationZ(getRadianFromDegree(rotationAnimation.value))..scale(btnChitConfigAnimation.value),
                                                   child: CircularButton(
                                                      width: 40,
                                                      height: 40,
                                                      color: model.theme.primary,
                                                      icon: Icon(Icons.settings, color: Colors.white,),
                                                      onClick: (){ 
                                                         dashboardDispose();
                                                         Navigator.pushNamed(context, "/chittemplate");
                                                      },
                                                   ),
                                                ),
                                             ]
                                          ),
                                       ),
                                       CircularButton(
                                          width: 50,
                                          height: 50,
                                          color: model.theme.primary,
                                          icon: Icon(Icons.add, color: Colors.white,),
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

   void dashboardDispose(){
      if(animationController.isCompleted){
         animationController.reverse();
      }
      memberSearchController.clear();
   }

   void setUpSearchMemberAutoComplete(BuildContext context){
      if(overlayState == null){
         overlayState = Overlay.of(context);
      }

      if(showAutocomplete){
         Future.delayed(Duration.zero, (){
            if(overlayEntries.length > 0){
               return;
            }
            overlayEntry = OverlayEntry(builder: (context){
               return Positioned(
                  top: searchMemberPosition.dy + searchMemberSize.height ?? 0,
                  left: searchMemberPosition.dx ?? 0,
                  child: Container(
                     constraints: BoxConstraints(maxHeight: (MediaQuery.of(context).size.height /100) * 40, minHeight: 0),
                     color: Colors.black12,
                     width: searchMemberSize.width,
                     child: Material(
                        color: Colors.transparent,
                        child: DashboardMemberSuggestions(
                           suggestedMembers: suggestedMembers,
                           removeOverlay: dashboardDispose,
                        ),
                     ),
                  ),
               );
            });
            overlayEntries = [overlayEntry];
            
            overlayState.insertAll(overlayEntries);
         });
      }else{
         Future.delayed(Duration.zero, (){
            if(overlayEntries.length > 0){
               overlayEntries[0].remove();
               overlayEntries = [];
            }
         });         
      }
   }
}

class DashboardSearch extends BaseModelWidget<DashboardViewModel>{
   final TextEditingController controller;
   final Key memberSearchkey;
   
   DashboardSearch({ @required this.controller, @required this.memberSearchkey });

   @override
   Widget build(BuildContext context, DashboardViewModel model){
      return Padding(
         padding: const EdgeInsets.only( left: 12.0, right: 12.0, top: 20.0),
         child: Container(
            key: memberSearchkey,
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

class DashboardMemberSuggestions extends StatelessWidget{

   final List<Member> suggestedMembers;
   // final DashboardViewModel model;
   final Function removeOverlay;
   DashboardMemberSuggestions({ @required this.suggestedMembers, this.removeOverlay });

   @override
   Widget build(BuildContext context) {
      DashboardViewModel model = locator<DashboardViewModel>();
      return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
            physics: BouncingScrollPhysics(),
            itemCount: suggestedMembers.length,
            itemBuilder: (context, index){
               Member member = suggestedMembers[index];
               return GestureDetector(
                  onTap: (){
                     // OverlayState overlayState = Overlay.of(context);
                     // overlayState.dispose();
                     if(removeOverlay != null){
                        removeOverlay();
                     }
                     print('Navigate to member page');
                  },
                  child: CustomCard(
                     bottomMargin: 5.0,
                     model: model,
                     child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              // Member name in bold
                              Text(member.name,
                                 style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: model.theme.black
                                 ),
                              ),
                              // phone number small
                              Text(member.phone,
                                 style: TextStyle(
                                    fontSize: 10,
                                    color: model.theme.black
                                 ),
                              )
                           ],
                        ),
                     ),
                  ),
               );
            }
         );
   }
}

class DashboardChitList extends BaseModelWidget<DashboardViewModel> {

   final Function dashboardDispose;

   DashboardChitList({ @required this.dashboardDispose });

   @override
   Widget build(BuildContext context, DashboardViewModel model) {
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chitsInfo.length,
         itemBuilder: (context, index){
            ChitInfo chitInfo = model.chitsInfo[index];
            return CustomCard(
               customCardGestures: CustomCardGestures(
                  onTap: (){
                     dashboardDispose();
                     print("Moveing to chit detail screen"); 
                     Map<String, dynamic> arg = { "chitId": chitInfo.id };
                     Navigator.pushNamed(context, "/installments", arguments: arg);                   
                  },
               ),
               model: model,
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
                                       label: model.language.labelChitName, 
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
                           SizedBox(height: 10.0,),
                           
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

                           SizedBox(height: 10.0,),
                           
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
            );
         }
      );
   }
}