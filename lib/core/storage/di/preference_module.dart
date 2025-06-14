import 'package:fithub_home_test/core/storage/di/storage_qualifier.dart';
import 'package:fithub_home_test/core/storage/hive/helper/type_def.dart';
import 'package:fithub_home_test/core/storage/hive/preference.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> registerPreference({
  required String appPreferenceName,
  required OpenPreference openPreference,
}) async {
  GetIt.I.registerLazySingletonAsync<Preference>(
    () async => await Preference.init(
      name: appPreferenceName,
      encryptionCipher: await GetIt.I.getAsync<HiveAesCipher>(),
      openPreference: openPreference,
    ),
    instanceName: StorageQualifier.appPreference.name,
  );
}

Future<Preference> getPreference() => GetIt.I.getAsync<Preference>(instanceName: StorageQualifier.appPreference.name);