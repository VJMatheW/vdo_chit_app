import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdo_chit_app/ui/chit_view/add_chit_view.dart';
import 'package:vdo_chit_app/ui/chit_view/chit_view.dart';
import 'package:vdo_chit_app/ui/chit_view/select_chit_members_view.dart';
import 'package:vdo_chit_app/ui/chit_view/select_chit_template_view.dart';
import 'package:vdo_chit_app/ui/member_view/add_member_view.dart';

import 'core/shared/ui/widgets/overlay_page_route.dart';
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
         return OverlayPageRoute(builder: (_) => AddChitTemplateView());
      case "/member":
         return CupertinoPageRoute(builder: (_) => MemberView());
      case "/addmember":
         return OverlayPageRoute(builder: (_) => AddMemberView());
      case "/chit":
         return CupertinoPageRoute(builder: (_) => ChitView());
      case "/addchit":
         return CupertinoPageRoute(builder: (_) => AddChitView(chit: settings.arguments,));
      case "/selectchittemplate":
         return OverlayPageRoute(builder: (_) => SelectChitTemplateView());
      case "/selectchitmembers":
         return OverlayPageRoute(builder: (_) => SelectChitMembersView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No router defined for ${settings.name}")),
          ),
        );
    }
  }
}
