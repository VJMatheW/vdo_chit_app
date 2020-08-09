import 'package:flutter/material.dart';
import './locator.dart';
import './ui/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  // for both orientation
  runApp(MyApp());

  // for vertical orientation
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  //   runApp(MyApp());
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: '/',
    );
  }
}
