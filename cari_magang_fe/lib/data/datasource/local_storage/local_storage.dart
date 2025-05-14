import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late Box _userBox;

  /// Inisialisasi Hive dan buka box
  static Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox('user');
  }

  /// Simpan token
  static void saveToken(String token) {
    _userBox.put('token', token);
  }

  /// Ambil token
  static String? getToken() {
    return _userBox.get('token');
  }

  /// Hapus token
  static void removeToken() {
    _userBox.delete('token');
  }
}
