import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vdo_chit_app/core/shared/ui/base_widget.dart';
import 'package:vdo_chit_app/locator.dart';
import 'package:vdo_chit_app/ui/chit_template_view.dart/chit_template_view_model.dart';

import '../preference_model.dart';

class ChitTemplateView extends StatelessWidget {
   const ChitTemplateView({ Key key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return BaseWidget(
         viewModel: locator<ChitTemplateViewModel>(),
         onModelReady: (model)=> model.init(),
         builder: (context){
            return Scaffold(
               backgroundColor: Provider.of<PreferenceModel>(context).theme.background,
               appBar: AppBar(
                  backgroundColor: Provider.of<PreferenceModel>(context).theme.primary,
                  actions: <Widget>[
                     IconButton(
                        icon: Icon(Icons.add), 
                        onPressed: ()=>{ print("open up settings") }
                     )
                  ],
                  title: Text(Provider.of<PreferenceModel>(context).language.appBarChitTemplate),
               ),
               body: Center(child: Text("Chit Template"),), 
            );
         }
      );
   }
}