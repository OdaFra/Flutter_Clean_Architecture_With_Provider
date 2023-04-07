import '../../domain/repositories/repositories.dart';

class ConnectivityRepositoryImp implements ConnectivityRepository {
  @override
  Future<bool> get hastInternet {
    return Future.value(true);
  }
}
