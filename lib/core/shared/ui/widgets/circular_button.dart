import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {

   final double width;
   final double height;
   final Color color;
   final Icon icon;
   final Function onClick;

   const CircularButton({ this.width, this.height, this.color, this.icon, this.onClick});

   @override
   Widget build(BuildContext context) {
      return Container(
         width: width,
         height: height,
         decoration: BoxDecoration(color: color, shape: BoxShape.circle),
         child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick), 
      );
   }
}