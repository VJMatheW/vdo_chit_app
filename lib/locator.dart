import 'package:get_it/get_it.dart';

import 'core/shared/services/contacts_service.dart';
import 'core/shared/services/db_service.dart';
import 'core/shared/services/permission_service.dart';
import 'core/shared/services/preference_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  print("Setuping LOCATOR");

  // Services
  locator.registerSingleton<PermissionService>(PermissionService());
  locator.registerSingleton<DBService>(DBService());
  locator.registerSingleton<ContactService>(ContactService());
  locator.registerLazySingleton<PreferenceService>(() => PreferenceService());

  // View Models
  // locator.registerLazySingleton<T>(() => T());
}
