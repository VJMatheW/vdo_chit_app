import 'package:flutter/material.dart';

import '../../core/enums_and_variables/info_state.dart';
import '../../core/shared/ui/base_widget.dart';
import '../../core/shared/ui/ui_widgets.dart';
import '../../locator.dart';
import 'chit_view_model.dart';

class SelectChitMembersView extends StatelessWidget {
   const SelectChitMembersView({ Key key }) : super(key: key);

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
                     padding: EdgeInsets.only(bottom: 15.0),
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
                                 // mainAxisSize: MainAxisSize.max,
                                 children: [
                                    SizedBox(height: 35, width: double.infinity,),
                                    UIWidgets.modalHeading("Select Members", model),
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
}