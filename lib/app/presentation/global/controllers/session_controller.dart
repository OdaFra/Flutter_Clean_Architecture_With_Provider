import '../../../domain/models/models.dart';
import '../../../domain/repositories/repositories.dart';
import '../../state_notifier.dart';

class SessionController extends StateNotifier<User?> {
  SessionController({
    required this.authenticationRepository,
  }) : super(null);

  final AuthenticationRepository authenticationRepository;

  void setUser(User user) {
    state = user;
  }

  signOut() async {
    await authenticationRepository.signOut();
    onlyUpdate(null);
  }
}
