import 'package:authentification/core/services/auth_service.dart';
import 'package:authentification/core/view_models/ClientModel.dart';
import 'package:authentification/core/view_models/MotherModel.dart';
import 'package:authentification/core/view_models/SubModel.dart';
import 'package:get_it/get_it.dart';
import 'core/services/api_service.dart';
import 'core/view_models/AuthModel.dart';

final locator = GetIt.instance ;

setupLocator(){
  locator.registerLazySingleton<ApiService>(()=>ApiService());
  locator.registerLazySingleton<AuthService>(()=>AuthService());
  locator.registerFactory<AuthModel>(()=>AuthModel());
  locator.registerFactory<MotherModel>(()=>MotherModel());
  locator.registerFactory<ClientModel>(()=>ClientModel());
  locator.registerFactory<SubModel>(()=>SubModel());
}