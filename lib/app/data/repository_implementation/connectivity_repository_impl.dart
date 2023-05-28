import 'package:connectivity_plus/connectivity_plus.dart';
import '../../domain/repositories/repositories.dart';
import '../services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl(
      {required Connectivity connectivity,
      required InternetChecker internetChecker})
      : _connectivity = connectivity,
        _internetChecker = internetChecker;
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;

  @override
  Future<bool> get hastInternet async {
    final result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }

    return _internetChecker.hasInternet();
  }
}
