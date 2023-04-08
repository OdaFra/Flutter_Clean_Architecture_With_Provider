import '../../domain/repositories/repositories.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  @override
  Future<bool> get hastInternet {
    return Future.value(true);
  }
}
