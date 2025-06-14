import 'package:fithub_home_test/core/storage/hive/helper/type_def.dart';
import 'package:hive_ce/hive.dart';

class Database<T> {
  late final Box<T> box;

  Database(this.box);

  static Future<Database<T>> init<T>({
    required String name,
    required OpenDatabase<T> openDatabase,
    HiveAesCipher? encryptionCipher,
  }) => openDatabase(
    module: "STORAGE",
    function: "OPEN_DATABASE",
    call: () async {
      final box = await Hive.openBox<T>(
        name,
        encryptionCipher: encryptionCipher,
      );
      return Database(box);
    },
  );
}
