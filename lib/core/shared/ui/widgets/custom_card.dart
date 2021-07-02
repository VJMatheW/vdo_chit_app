import 'package:flutter/material.dart';
import 'package:vdo_chit_app/ui/base_model.dart';

class CustomCard extends StatelessWidget {

   final BaseModel model;
   final Widget child;
  const CustomCard({ Key key, this.model, this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      // elevation: 3.0,
      decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(3.0)),
         boxShadow: [
            BoxShadow(
               blurRadius: 4.0,
               color: Colors.black26,
               offset: Offset(1, 2),
               spreadRadius: 0.0
            )
         ]
      ),
      child: child,
    );
  }
}