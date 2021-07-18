import 'package:flutter/material.dart';

import '../../../../ui/base_model.dart';

class Cell extends StatelessWidget {
   
   final label;
   final value;
   final IconData icon;
   final isPhoneNumber;
   final BaseModel model;
   final double labelFontSize;
   final double valueFontSize;

   Cell({ Key key, @required this.label, @required this.value, this.icon, this.isPhoneNumber = false, this.model, this.labelFontSize = 10.0, this.valueFontSize = 20.0 }) : super(key: key);

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
                                 fontSize: labelFontSize,
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
                           fontSize: valueFontSize,
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
               child: Icon(Icons.phone_forwarded, color: model.theme.primary,)
            )
         ],
      );
   }
}