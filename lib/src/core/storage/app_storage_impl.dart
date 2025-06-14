import 'package:shared_preferences/shared_preferences.dart';

import 'app_storage.dart';

/// Concrete implementation of AppStorage using SharedPreferences
class AppStorageImpl implements AppStorage {
  AppStorageImpl(this._prefs);

  final SharedPreferences _prefs;

  /// Factory constructor to create instance with SharedPreferences
  static Future<AppStorageImpl> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AppStorageImpl(prefs);
  }

  @override
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      return false;
    }
  }

  @override
  bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      return false;
    }
  }

  @override
  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      return false;
    }
  }

  @override
  double? getDouble(String key) {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      return false;
    }
  }

  @override
  List<String>? getStringList(String key) {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      return false;
    }
  }

  @override
  bool containsKey(String key) {
    try {
      return _prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  @override
  Set<String> getKeys() {
    try {
      return _prefs.getKeys();
    } catch (e) {
      return <String>{};
    }
  }

  @override
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> reload() async {
    try {
      await _prefs.reload();
    } catch (e) {
      // Silently handle reload errors
    }
  }
}
