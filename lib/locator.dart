import 'package:get_it/get_it.dart';
import 'package:take_note/core/services/auth_utils.dart';
import 'package:take_note/core/viewmodels/cloud_model.dart';
import 'package:take_note/core/viewmodels/documents_model.dart';

GetIt locator =  GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthUtils());
  locator.registerLazySingleton(() => DocumentModel());
  locator.registerLazySingleton(() => CloudModel());

}