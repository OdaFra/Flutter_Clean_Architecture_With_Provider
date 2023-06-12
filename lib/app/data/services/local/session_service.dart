import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId;
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> signOut() {
    return _secureStorage.delete(key: _key);
  }
}
