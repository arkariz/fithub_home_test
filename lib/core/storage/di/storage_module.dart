import 'package:fithub_home_test/core/storage/di/storage_qualifier.dart';
import 'package:fithub_home_test/core/storage/hive/helper/secure_storage.dart';
import 'package:fithub_home_test/core/storage/hive/helper/type_def.dart';
import 'package:fithub_home_test/core/storage/hive/preference.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> registerStorageService({
  required String appPreferenceName,
  required String keySecureStorage,
  required OpenPreference openPreference,
}) async {
  // setup hive local storage
  await Hive.initFlutter();

  // setup secure storage
  final secureStorage = SecureStorage(key: keySecureStorage);

  //inject secure storage for database
  GetIt.I.registerLazySingletonAsync<HiveAesCipher>(() async => await secureStorage.generateKey());

  // setup preference
  GetIt.I.registerLazySingletonAsync<Preference>(
    () async => await Preference.init(
      name: appPreferenceName,
      encryptionCipher: await getHiveAesCipher(),
      openPreference: openPreference,
    ),
    instanceName: StorageQualifier.appPreference.name,
  );
}

Future<Preference> getPreference() => GetIt.I.getAsync<Preference>(instanceName: StorageQualifier.appPreference.name);
Future<HiveAesCipher> getHiveAesCipher() => GetIt.I.getAsync<HiveAesCipher>();