import 'package:flutter/material.dart';

import '../../../../ui/base_model.dart';

class CustomCard extends StatelessWidget {

   final BaseModel model;
   final Widget child;
   CustomCardGestures customCardGestures;
   final double bottomMargin;
   
   CustomCard({ Key key, this.model, this.child, this.bottomMargin = 15.0, this.customCardGestures }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
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
         child: Material(
            color: Colors.transparent,
            child: InkWell(
               onTap: customCardGestures?.onTap,
               onLongPress: customCardGestures?.onLongPress,
               child: Container(
                  color: Colors.transparent,
                  child: child
               ),
            ),
         ),
      );
   }
}

class CustomCardGestures{
   Function onTap;
   Function onLongPress;

   CustomCardGestures({ this.onTap, this.onLongPress});
}