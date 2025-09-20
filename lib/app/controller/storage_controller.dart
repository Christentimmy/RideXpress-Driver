import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageController extends GetxController {
  // final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Store token
  Future<void> storeToken(String token) async {
    await _secureStorage.write(key: 'userToken', value: token);
  }

  // Get token
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: 'userToken');
    } catch (e) {
      // If decryption fails, clear all data and return null
      await _secureStorage.deleteAll();
      return null;
    }
  }

  // Delete token
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'userToken');
  }

  //user status
  Future<bool> getUserStatus() async {
    try {
      final String? value = await _secureStorage.read(key: "newUser");
      return value != null ? true : false;
    } catch (e) {
      await _secureStorage.deleteAll();
      return false;
    }
  }

  Future<void> saveStatus(String value) async {
    await _secureStorage.write(key: "newUser", value: value);
  }

  Future<void> saveLastPushId({
    required String userId,
    required String oneSignalId,
  }) async {
    await _secureStorage.write(key: 'push_id_$userId', value: oneSignalId);
  }

  Future<String?> getLastPushId(String userId) async {
    return _secureStorage.read(key: 'push_id_$userId');
  }
}
