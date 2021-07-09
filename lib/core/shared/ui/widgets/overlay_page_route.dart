import 'package:flutter/material.dart';

class OverlayPageRoute<T> extends PageRoute<T>{
   
   final WidgetBuilder _builder;
   
   OverlayPageRoute({ @required builder, RouteSettings settings, bool fullScreenDialogParam = false })
      : _builder = builder,
      super(settings: settings, fullscreenDialog: fullScreenDialogParam);

   @override
   Color get barrierColor => Colors.black54;

   @override
   bool get opaque => false;

   @override
   bool get barrierDismissible => false;

   @override
   String get barrierLabel => "Hero Page Route Dialog";

   @override
   bool get maintainState => true;

   @override
   Duration get transitionDuration => Duration(milliseconds: 300);

   @override
   Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return _builder(context);
   }

}