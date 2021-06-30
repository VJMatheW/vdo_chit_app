import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'ui/preference_model.dart';
import 'locator.dart';
import 'router.dart';

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
    return ChangeNotifierProvider.value(
       value: locator<PreferenceModel>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chit App',
        onGenerateRoute: CustomRouter.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
