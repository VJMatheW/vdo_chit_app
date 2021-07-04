import 'package:flutter/material.dart';

import '../../../../ui/base_model.dart';

class CustomCard extends StatelessWidget {

   final BaseModel model;
   final Widget child;
   double bottomMargin;
   
   CustomCard({ Key key, this.model, this.child, this.bottomMargin = 15.0 }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Container(
         margin: EdgeInsets.only(bottom: bottomMargin),
         // elevation: 3.0,
         decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            boxShadow: [
               BoxShadow(
                  blurRadius: 4.0,
                  color: model.theme.cardShadow,
                  offset: Offset(1, 2),
                  spreadRadius: 0.0
               )
            ]
         ),
         child: child,
      );
   }
}