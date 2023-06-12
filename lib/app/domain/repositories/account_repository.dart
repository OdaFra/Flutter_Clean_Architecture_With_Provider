import '../models/models.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
}
