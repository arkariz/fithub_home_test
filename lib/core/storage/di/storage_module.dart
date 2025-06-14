import 'package:fithub_home_test/core/storage/hive/helper/secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> registerStorageModule({
  required String keySecureStorage,
}) async {
  // setup hive local storage
  await Hive.initFlutter();

  // setup secure storage
  final secureStorage = SecureStorage(key: keySecureStorage);

  //inject secure storage for database
  GetIt.I.registerLazySingletonAsync<HiveAesCipher>(() async => await secureStorage.generateKey());
}

Future<HiveAesCipher> getHiveAesCipher() => GetIt.I.getAsync<HiveAesCipher>();