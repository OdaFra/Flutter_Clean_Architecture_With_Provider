import '../../../domain/models/user.dart';
import '../../http/httpManagement.dart';

class AccountApi {
  AccountApi(this._httpManagement);
  final HttpManagement _httpManagement;

  Future<User?> getAccount(String sessionId) async {
    final result = await _httpManagement.request(
      '/account',
      queryParameters: {
        'session_id': sessionId,
      },
      onSuccess: (responseBody) {
        final json = responseBody as Map<String, dynamic>;
        return User.fromMap(
          json
        );
      },
    );
    return result.when(
      (_) => null,
      (user) => user,
    );
  }
}
