import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../ui/base_model.dart';
import 'utils.dart';

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

   static Widget textInput({
      @required BuildContext context,
      bool autoFocus,
      TextEditingController controller,
      String hintText,
      TextInputType inputType,
      String suffixText,
      String initialValue,
      BaseModel model,
      IconData prefixIcon,
   }) {
      return TextFormField(
         autofocus: autoFocus ??= false,
         controller: controller,
         style: TextStyle( fontSize: 17, color: model.theme.secondary ),
         keyboardType: inputType ??= TextInputType.text,
         cursorWidth: 1.5,         
         cursorColor: model.theme.secondary,

         decoration: InputDecoration(
            contentPadding: EdgeInsets.all(2),
            hintStyle: TextStyle(
               color: model.theme.secondary,
               fontSize: 15.0
            ),
            focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(color: model.theme.secondary)
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
               color: model.theme.primary,
            ),
            prefixStyle: TextStyle(
               fontSize: 20,
            ),
         ),
         maxLines: 1,
      );
   }

   static Widget textInputLabel(
         {@required BuildContext context, @required String label}) {
      return Padding(
         padding: EdgeInsets.fromLTRB(
         screenAwareSize(0, context),
         screenAwareSize(10, context),
         screenAwareSize(7, context),
         screenAwareSize(3, context),
         ),
         child: Text(
         label ??= "",
         textAlign: TextAlign.left,
         style: Theme.of(context).textTheme.headline2.copyWith(
               fontSize: screenAwareSize(13, context),
               fontWeight: FontWeight.bold),
         ),
      );
   }

   static Widget buttonSuccess(
         {BuildContext context, String label, Function onPressed}) {
      return Padding(
         padding: EdgeInsets.symmetric(
         vertical: screenAwareSize(10, context),
         ),
         child: MaterialButton(
         padding: EdgeInsets.all(screenAwareSize(buttonPadding, context)),
         textColor: Colors.white,
         child: Text(
            label ??= "",
            style: TextStyle(
               fontSize: screenAwareSize(buttonFontSize, context),
            ),
         ),
         color: Theme.of(context).accentColor,
         disabledColor: Theme.of(context).buttonColor,
         disabledTextColor: Colors.black26,
         onPressed: onPressed,
         ),
      );
   }

   static Widget buttonBasic(
         {BuildContext context, String label, Function onPressed}) {
      return Padding(
         padding: EdgeInsets.symmetric(
         vertical: screenAwareSize(10, context),
         ),
         child: MaterialButton(
         padding: EdgeInsets.all(screenAwareSize(buttonPadding, context)),
         textColor: Colors.black45,
         child: Text(
            label ??= "",
            style: TextStyle(
               fontSize: screenAwareSize(buttonFontSize, context),
            ),
         ),
         color: Theme.of(context).buttonColor,
         disabledColor: Theme.of(context).buttonColor,
         disabledTextColor: Colors.black26,
         onPressed: onPressed,
         ),
      );
   }
}
