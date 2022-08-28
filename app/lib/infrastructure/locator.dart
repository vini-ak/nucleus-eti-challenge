import 'package:get_it/get_it.dart';
import 'package:nucleus_agenda/services/classes/contact_service.dart';
import 'package:nucleus_agenda/view/controllers/contacts_controller.dart';

final locator = GetIt.instance;

setupLocator() {
  // Services
  locator.registerLazySingleton(() => ContactService());

  // Controllers
  locator.registerLazySingleton(() => ContactController());
}
