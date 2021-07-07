import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdo_chit_app/ui/member_view/add_member_view.dart';

import 'core/shared/ui/widgets/hero_page_route.dart';
import 'ui/chit_template_view.dart/add_chit_template_view.dart';
import 'ui/chit_template_view.dart/chit_template_view.dart';
import 'ui/dashboard_view/dashboard_view.dart';
import 'ui/member_view/member_view.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
         return MaterialPageRoute(builder: (_) => DashboardView());
      case "/chittemplate":
         return CupertinoPageRoute(builder: (_) => ChitTemplateView());
      case "/addchittemplate":
         return HeroPageRoute(builder: (_) => AddChitTemplateView());
      case "/member":
         return CupertinoPageRoute(builder: (_) => MemberView());
      case "/addmember":
         return HeroPageRoute(builder: (_) => AddMemberView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No router defined for ${settings.name}")),
          ),
        );
    }
  }
}
