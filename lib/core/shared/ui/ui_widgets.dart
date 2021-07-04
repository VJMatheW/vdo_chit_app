import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/base_model.dart';

class UIWidgets {
   static double textFontSize = 15;
   static double hintFontSize = 16;
   static double suffixFontSize = 12;
   static double borderRadius = 3;
   static double buttonFontSize = 11;
   static double buttonPadding = 11;

   static Widget heading(String text, BaseModel model){
      return Text(
         text.toUpperCase(),
         style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            color: model.theme.primary,
         ),
      );
   }

   static Widget modalHeading(String text, BaseModel model){
      return Text(
         text.toUpperCase(),
         style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: model.theme.primary,
         ),
      );
   }

   static Widget textInput({
      @required BuildContext context,
      bool autoFocus,
      TextEditingController controller,
      String hintText,
      TextInputType inputType,
      String suffixText,
      String initialValue,
      @required BaseModel model,
      IconData prefixIcon,
   }) {
      return TextFormField(
         autofocus: autoFocus ??= false,
         controller: controller,
         style: TextStyle( fontSize: 17, color: model.theme.inputText ),
         keyboardType: inputType ??= TextInputType.text,
         cursorWidth: 1.5,         
         cursorColor: model.theme.secondary,

         decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            hintStyle: TextStyle(
               color: model.theme.inputTextHint,
               fontSize: 15.0,
               fontWeight: FontWeight.w500,
            ),
            focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(color: model.theme.primary)
            ),
            enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(color: model.theme.secondary),
               borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
            hintText: hintText ??= "",
            suffixText: suffixText ??= "",
         ),
         maxLines: 1,
      );
   }

   static Widget textInputWithPrefixIcon({
      @required BuildContext context,
      bool autoFocus,
      TextEditingController controller,
      String hintText,
      TextInputType inputType,
      String suffixText,
      String initialValue,
      @required BaseModel model,
      IconData prefixIcon,
   }) {
      return TextField(
         autofocus: autoFocus ??= false,
         controller: controller,
         style: TextStyle( fontSize: 17, color: model.theme.inputText ),
         keyboardType: inputType ??= TextInputType.text,
         cursorWidth: 1.5,         
         cursorColor: model.theme.inputTextHint,

         decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5.0),
            hintStyle: TextStyle(
               color: model.theme.secondary,
               fontSize: 15.0
            ),
            focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(color: model.theme.primary)
            ),
            enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(color: model.theme.secondary),
               borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
            hintText: hintText ??= "",
            suffixText: suffixText ??= "",
            prefixIcon: Icon(
               prefixIcon,
               size: 20,
               color: model.theme.inputTextHint,
            ),
            prefixStyle: TextStyle(
               fontSize: 20,
            ),
         ),
         maxLines: 1,
      );
   }

   static Widget textInputLabel(
         {@required BuildContext context, @required String label, @required BaseModel model}) {
      return Padding(
         padding: EdgeInsets.fromLTRB(0,0,0,5.0),
         child: Text(
            label ??= "",
            textAlign: TextAlign.left,
            style: TextStyle(
               fontSize: 13, 
               fontWeight: FontWeight.w700, 
               color: model.theme.primary
            )
         )
      );
   }

   static Widget buttonSuccess(
         {BuildContext context, String label, Function onPressed, @required BaseModel model}) {
      return MaterialButton(
         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
         textColor: model.theme.white,
         child: Text(
            label ??= "",
            style: TextStyle(
               fontSize: 14.0,
               fontWeight: FontWeight.w600,
            ),
         ),
         color: model.theme.primary,
         disabledColor: Theme.of(context).buttonColor,
         disabledTextColor: Colors.black26,
         onPressed: onPressed,
      );
   }

   static Widget buttonBasic(
         {BuildContext context, String label, Function onPressed, @required BaseModel model}) {
      return MaterialButton(
         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
         textColor: model.theme.primary,
         shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            side: BorderSide(color: model.theme.primary),
         ),
         child: Text(
            label ??= "",
            style: TextStyle(
               fontSize: 14.0,
               fontWeight: FontWeight.w400,            
            ),
         ),
         // color: Theme.of(context).buttonColor,
         disabledColor: Theme.of(context).buttonColor,
         disabledTextColor: Colors.black26,
         onPressed: onPressed,
      
      );
   }
}
