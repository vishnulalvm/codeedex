import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  late GetStorage _box;

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  Future<void> init() async {
    await GetStorage.init();
    _box = GetStorage();
  }

  // Auth related storage
  Future<void> saveUserId(String userId) async {
    await _box.write('user_id', userId);
  }

  String? getUserId() {
    return _box.read('user_id');
  }

  Future<void> saveToken(String token) async {
    await _box.write('token', token);
  }

  String? getToken() {
    return _box.read('token');
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.write('user_data', userData);
  }

  Map<String, dynamic>? getUserData() {
    return _box.read('user_data');
  }

  bool isLoggedIn() {
    return getToken() != null && getUserId() != null;
  }

  Future<void> clearAuthData() async {
    await _box.remove('user_id');
    await _box.remove('token');
    await _box.remove('user_data');
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
}
