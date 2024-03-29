import '../../../domain/models/models.dart';
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
        return User.fromJson(json);
      },
    );
    return result.when(
      left: (_) => null,
      right: (user) => user,
    );
  }
}
