import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdo_chit_app/core/enums_and_variables/info_state.dart';
import 'package:vdo_chit_app/core/shared/ui/ui_widgets.dart';
import 'package:vdo_chit_app/core/shared/ui/widgets/custom_card.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/widgets/cell.dart';
import '../../core/data_models/data_models.dart';
import '../../locator.dart';
import '../base_model_widget.dart';
import 'chit_info_view_model.dart';

class ChitInfoView extends StatefulWidget {
   
   ChitInfoView({ Key key, dynamic data }): super(key: key){
      locator<ChitInfoViewModel>().setChitId(data);
   }

   @override
   _ChitInfoViewState createState() => _ChitInfoViewState();
}

class _ChitInfoViewState extends State<ChitInfoView> {

   @override
   void initState() {
      super.initState();
   }

   @override
   void dispose(){
      super.dispose();
   }

   @override
   Widget build(BuildContext context) {
       return BaseWidget(
         viewModel: locator<ChitInfoViewModel>(),
         onModelReady: (model) => model.init(),
         builder: (context, ChitInfoViewModel model, child){
            return Scaffold(
               backgroundColor: model.theme.background,
               appBar: AppBar(
                  backgroundColor: model.theme.primary,
                  title: Text(model.chitInfo.name),
               ),
               body: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: model.state == ViewState.Busy
                     ? Center(child: CupertinoActivityIndicator(),)
                     : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           ChitInfo(),
                           ChitInfoHeading(),
                           Expanded(
                              flex: 1,
                              child: ChitInfoInstallment()
                           )
                        ],
                     ),
               ),
            );
         },
      );
   }
}

class ChitInfo extends BaseModelWidget<ChitInfoViewModel>{
   @override
   Widget build(BuildContext context, ChitInfoViewModel model){
      var chitInfo = model.chitInfo;
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
               SizedBox(height: 8.0,),
               
               // ROW 2
               Row(
                  children: [
                     Expanded( 
                        flex: 1, 
                        child:  Cell(
                           label: model.language.labelChitDate, 
                           value: chitInfo.chitDay, 
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
               )
            ],
         ),
      );
   }
}

class ChitInfoHeading extends BaseModelWidget<ChitInfoViewModel>{
   @override
   Widget build(BuildContext context, ChitInfoViewModel model){
      return Padding(
         padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
         child: Row(
            children: [
               Expanded(child: UIWidgets.heading(model.language.headingChitInstallments, model)),
               GestureDetector(
                  child: Icon(Icons.add_box_rounded, size: 20.0, color: model.theme.primary),
                  onTap: (){
                     print("Move to Add Installment screen");
                  },
               )
            ],
         )
      );
   }
}

class ChitInfoInstallment extends BaseModelWidget<ChitInfoViewModel>{
   @override
   Widget build(BuildContext context, ChitInfoViewModel model){
      return ListView.builder(
         padding: const EdgeInsets.symmetric(horizontal: 12.0),
         physics: BouncingScrollPhysics(),
         itemCount: model.chitInfo.installments.length,
         itemBuilder: (context, index){
            Installment installment = model.chitInfo.installments[index];
            return CustomCard(
               customCardGestures: CustomCardGestures(
                  onTap: (){
                     print("Moveing to chit detail screen"); 
                     Map<String, dynamic> arg = { "installmentId": installment.id, "installmentNo": installment.installmentNo };
                     Navigator.pushNamed(context, "/installment", arguments: arg);                   
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
                                    label: model.language.labelInstallmentNo, 
                                    value: installment.installmentNo, 
                                    model: model
                                 )
                              ),
                              Expanded(
                                 flex: 1,
                                 child: Cell(
                                    label: model.language.labelBidAmount, 
                                    value: installment.finalBidAmount, 
                                    model: model,
                                 ), 
                              ),
                              Expanded(
                                 flex: 1,
                                 child: Cell(
                                    label: model.language.labelPayableAmount, 
                                    value: installment.payableAmount, 
                                    model: model,
                                 ), 
                              )
                           ],
                        ),
                        SizedBox(height: 8.0,),
                        
                        // ROW 2
                        Row(
                           children: [
                              Expanded( 
                                 flex: 1, 
                                 child: Cell(
                                    label: model.language.labelBidderName, 
                                    value: installment.bidder.name,
                                    model: model,
                                 ),
                              ),
                              Expanded(
                                 flex: 1,
                                 child: Cell(
                                    label: model.language.labelMembers, 
                                    value: installment.bidder.phone,
                                    model: model,
                                    isPhoneNumber: true
                                 ),
                              ),
                           ],
                        )
                     ],
                  ),
               ),
            );
         },
      );
   }
}
