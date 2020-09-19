import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './locator.dart';
import './router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  // for both orientation
  // runApp(MyApp());

  // for vertical orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<InitViewModel>.value(
      value: locator<InitViewModel>(),
      child: Consumer<InitViewModel>(
        builder: (context, model, child) {
          return MaterialApp(
            title: 'Chit App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: Router.generateRoute,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
