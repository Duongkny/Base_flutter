import 'package:base_flutter/hive/hive_registrar.g.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../logger/logger.dart';
import 'local_storage_key.dart';

class AppLocalStorage {
  static String currentLanguageCode = "";

  static Box<dynamic>? get _openedLocalBox {
    if (Hive.isBoxOpen(LocalStorageKey.localStorage)) {
      return Hive.box(LocalStorageKey.localStorage);
    }
    return null;
  }

  static Box<dynamic> get localBox {
    if (!Hive.isBoxOpen(LocalStorageKey.localStorage)) {
      throw StateError(
        'Hive box "${LocalStorageKey.localStorage}" is not opened yet. '
        'Make sure to await AppLocalStorage().initLocalStorage() before accessing localBox.',
      );
    }
    return Hive.box(LocalStorageKey.localStorage);
  }

  static void create(Map data) {
    localBox.add(data);
  }

  static dynamic get(dynamic key) {
    final box = _openedLocalBox;
    if (box == null) {
      return null;
    }
    return box.get(key);
  }

  static void update<E>(dynamic key, E data) {
    final box = _openedLocalBox;
    if (box != null) {
      box.put(key, data);
    } else {
      Hive.openBox(LocalStorageKey.localStorage).then((openedBox) {
        openedBox.put(key, data);
      });
    }
  }

  static Future<void> delete(dynamic key) async {
    final box = Hive.isBoxOpen(LocalStorageKey.localStorage)
        ? Hive.box(LocalStorageKey.localStorage)
        : await Hive.openBox(LocalStorageKey.localStorage);
    await box.delete(key);
  }

  static String getNowTime() {
    return DateTime.now().toString();
  }

  static bool isRegisterAdapters = false;

  Future<void> initLocalStorage() async {
    await Hive.initFlutter();
    if (!isRegisterAdapters) {
      Hive.registerAdapters();
      isRegisterAdapters = true;
    }

    // Mở các box
    try {
      await Future.wait([
        Hive.openBox(LocalStorageKey.localStorage),
        Hive.openBox(LocalStorageKey.token),
      ]);
      logger.d("Đã mở tất cả các box thành công");
    } catch (error) {
      logger.e("Lỗi khi mở box: $error");
    }
  }
}
