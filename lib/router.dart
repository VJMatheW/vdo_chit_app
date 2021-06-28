import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ui/dashboard_view/dashboard_view.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
         return MaterialPageRoute(builder: (_) => DashboardView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No router defined for ${settings.name}")),
          ),
        );
    }
  }
}
