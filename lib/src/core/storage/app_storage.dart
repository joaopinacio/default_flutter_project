/// Abstract interface for key-value storage operations
abstract class AppStorage {
  /// Get a string value by key
  String? getString(String key);

  /// Set a string value by key
  Future<bool> setString(String key, String value);

  /// Get a boolean value by key
  bool? getBool(String key);

  /// Set a boolean value by key
  Future<bool> setBool(String key, bool value);

  /// Get an integer value by key
  int? getInt(String key);

  /// Set an integer value by key
  Future<bool> setInt(String key, int value);

  /// Get a double value by key
  double? getDouble(String key);

  /// Set a double value by key
  Future<bool> setDouble(String key, double value);

  /// Get a string list value by key
  List<String>? getStringList(String key);

  /// Set a string list value by key
  Future<bool> setStringList(String key, List<String> value);

  /// Remove a value by key
  Future<bool> remove(String key);

  /// Check if a key exists
  bool containsKey(String key);

  /// Get all keys
  Set<String> getKeys();

  /// Clear all stored data
  Future<bool> clear();

  /// Reload preferences from storage
  Future<void> reload();
}
