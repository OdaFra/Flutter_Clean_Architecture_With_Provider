import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';
const _accountKey = 'accountId';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  // Para obtener el key de la sessionId
  Future<String?> get sessionId async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId;
  }

//Para obtener el key del accountId
  Future<String?> get accountId async {
    final accountKey = await _secureStorage.read(key: _accountKey);
    return accountKey;
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) {
    return _secureStorage.write(
      key: _accountKey,
      value: accountId,
    );
  }

  Future<void> signOut() {
    return _secureStorage.deleteAll();
    // await _secureStorage.delete(key: _key);
  }
}
