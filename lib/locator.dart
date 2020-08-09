import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  print("Setuping LOCATOR");
  locator.registerSingleton<T>(T());
  locator.registerLazySingleton<T>(() => T());
}
