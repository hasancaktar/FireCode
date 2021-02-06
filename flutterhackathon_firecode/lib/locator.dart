import 'package:flutterhackathon_firecode/repository/repository.dart';
import 'package:flutterhackathon_firecode/services/auth/fakeauthservice.dart';
import 'package:flutterhackathon_firecode/services/auth/firebaseauthservice.dart';
import 'package:flutterhackathon_firecode/services/db/firestoredbservice.dart';
import 'package:flutterhackathon_firecode/services/storage/firebasestorage.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

void setupLocator(){
 locator.registerLazySingleton(() => FirebaseAuthService());
 locator.registerLazySingleton(() => FakeAuthService());
 locator.registerLazySingleton(() => Repository());
 locator.registerLazySingleton(() => FireStoreDBService());
 locator.registerLazySingleton(() => FirebaseStorageService());
}