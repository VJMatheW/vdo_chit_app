import 'package:flutter/material.dart';

import '../../../../ui/base_model.dart';

class Cell extends StatelessWidget {
   
   final label;
   final value;
   final icon;
   final isPhoneNumber;
   final BaseModel model;

   const Cell({ Key key, @required this.label, @required this.value, this.icon, this.isPhoneNumber = false, this.model }) : super(key: key);

   @override
   Widget build(BuildContext context) {
      return Row(
         children: [
            Expanded(
               flex: 1,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     // Label with icon
                     Row(
                        children: [
                           Text(
                              label, 
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                 fontSize: 10.0,
                                 color: model.theme.primary
                                 )
                              ),
                           // ICON
                           icon != null 
                           ? Padding(
                             padding: const EdgeInsets.only(left:8.0),
                             child: Icon(icon, color: model.theme.primary, size: 15,),
                           )
                           : Container()
                        ],
                     ),
                     // Value
                     Text(value.toString(),  
                        style: TextStyle(
                           fontSize: 20.0,
                           fontWeight: FontWeight.w400,
                           ),
                        // textAlign: TextAlign.left,
                     )
                  ],
               )
            ),
            
            // Phone icon
            !isPhoneNumber 
            ? Container()
            : GestureDetector(
               onTap: (){
                  print("Call the number");
               },
               child: Icon(Icons.phone_forwarded)
            )
         ],
      );
   }
}