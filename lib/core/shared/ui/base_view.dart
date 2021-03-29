import 'package:flutter/material.dart';
import './utils.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final String title;
  bool isDrawerNeeded;

  BaseView({@required this.child, this.title, this.isDrawerNeeded});

  @override
  Widget build(BuildContext context) {
    double iconSize = 30.0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[],
        ),
        drawer: Drawer(
          child: ListView(children: <Widget>[
            DrawerHeader(
                child: Text("Vdo\nChitApp",
                    style: Theme.of(context).accentTextTheme.headline3),
                decoration:
                    BoxDecoration(color: Theme.of(context).accentColor)),

            /// Add member
            ListTile(
              leading: Icon(
                Icons.person,
                size: screenAwareSize(iconSize, context),
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "User",
                style: Theme.of(context).textTheme.headline5,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/user");
              },
            ),

            /// Chit view
            ListTile(
              leading: Icon(
                Icons.perm_contact_calendar,
                size: screenAwareSize(iconSize, context),
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Chits",
                style: Theme.of(context).textTheme.headline5,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/chit");
              },
            ),

            /// Chit Config
            ListTile(
              leading: Icon(
                Icons.settings,
                size: screenAwareSize(iconSize, context),
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Chit Config",
                style: Theme.of(context).textTheme.headline5,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/chitconfig");
              },
            ),

            /// Member Config
            ListTile(
              leading: Icon(
                Icons.people,
                size: screenAwareSize(iconSize, context),
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Member Config",
                style: Theme.of(context).textTheme.headline5,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/addmemberconfig");
              },
            ),
          ]),
        ),
        body: Padding(padding: EdgeInsets.all(5.0), child: child),
      ),
    );
  }
}

class SimpleBaseView extends StatelessWidget {
  final Widget child;
  final String title;

  SimpleBaseView({@required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[],
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
