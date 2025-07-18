// create get storage helper
import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:get_storage/get_storage.dart';

class BoxHelper {
  final GetStorage _storage = GetStorage();

  // Initialize storage
  Future<void> init() async {
    await GetStorage.init().then((value) {
      if (value) {
        LoggerHelper.logInfo('Get Storage successfully initialized');
      } else {
        LoggerHelper.logWarning('Get Storage failed to initialized');
      }
    });
  }

  // Set a value in storage
  Future<void> setValue(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  // Get a value from storage
  dynamic getValue(String key) {
    return _storage.read(key);
  }

  // Return true if storage is null
  bool isNull(String key) {
    return _storage.read(key) == null;
  }

  // Check if a key exists in storage
  bool hasKey(String key) {
    return _storage.hasData(key);
  }

  // Remove a value from storage
  Future<void> removeValue(String key) async {
    await _storage.remove(key);
  }

  // Clear all storage
  Future<void> clearStorage() async {
    await _storage.erase();
  }
}
