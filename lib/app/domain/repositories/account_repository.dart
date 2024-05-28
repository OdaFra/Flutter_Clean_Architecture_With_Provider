import '../../core/utils/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/media/media.dart';
import '../models/models.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
    MediaType type,
  );
  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required MediaType type,
    required bool favorite,
  });
}
