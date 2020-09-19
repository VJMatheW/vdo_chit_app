import 'package:flutter/material.dart';

import './utils.dart';

class UIWidgets {
  static double textFontSize = 13;
  static double hintFontSize = 13;
  static double suffixFontSize = 12;
  static double borderRadius = 3;
  static double buttonFontSize = 11;
  static double buttonPadding = 11;

  static Widget textInput({
    @required BuildContext context,
    bool autoFocus,
    TextEditingController controller,
    String hintText,
    TextInputType inputType,
    String suffixText,
    String initialValue,
  }) {
    return TextFormField(
      autofocus: autoFocus ??= false,
      controller: controller,
      style: TextStyle(
        fontSize: screenAwareSize(textFontSize, context),
      ),
      keyboardType: inputType ??= TextInputType.text,
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.headline5.copyWith(
              fontSize: screenAwareSize(hintFontSize, context),
              color: Theme.of(context).hintColor,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(screenAwareSize(borderRadius, context))),
        ),
        hintText: hintText ??= "",
        suffixText: suffixText ??= "",
        suffixStyle: Theme.of(context).textTheme.headline5.copyWith(
              fontSize: screenAwareSize(suffixFontSize, context),
              color: Theme.of(context).primaryColor,
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

  static Widget headText(
      {@required BuildContext context, @required String text}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
