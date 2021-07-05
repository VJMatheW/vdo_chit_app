import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/data_access/data_access.dart';
import 'core/shared/services/contacts_service.dart';
import 'core/shared/services/http_service.dart';
import 'core/shared/services/permission_service.dart';
import 'core/shared/services/preference_service.dart';

import 'ui/chit_template_view.dart/chit_template_view_model.dart';
import 'ui/dashboard_view/dashboard_view_model.dart';
import 'ui/preference_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
   print("Setuping LOCATOR");

   // Services
   locator.registerSingleton<HttpService>(HttpService(http.Client()));  // injection client from http package
   locator.registerSingleton<PermissionService>(PermissionService());
   locator.registerSingleton<ContactService>(ContactService());
   locator.registerLazySingleton<PreferenceService>(() => PreferenceService());

   // data access
   locator.registerLazySingleton<ChitDataAccess>(() => ChitDataAccess());
   locator.registerLazySingleton<ChitTemplateDataAccess>(() => ChitTemplateDataAccess());

   // Models
   locator.registerSingleton<PreferenceModel>(PreferenceModel());

   // View Models
   locator.registerLazySingleton<DashboardViewModel>(() => DashboardViewModel());
   locator.registerLazySingleton<ChitTemplateViewModel>(() => ChitTemplateViewModel());
}
