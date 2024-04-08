import 'package:hive/hive.dart';

class HiveManager {
  static Future<void> saveData(String boxName, String key, dynamic data) async {
    var box = await Hive.openBox(boxName);
    await box.put(key, data);
  }

  static Future<dynamic> getData(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    return box.get(key);
  }

  static Future<void> deleteData(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    await box.delete(key);
  }

  static Future<void> clearBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}
