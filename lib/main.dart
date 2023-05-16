import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app/data/http/http.dart';
import 'app/data/repository_implementation/authentication_repository_impl.dart';
import 'app/data/repository_implementation/connectivity_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/repositories.dart';
import 'app/my_app.dart';

void main() async {
  await dotenv.load();
  runApp(
    Injector(
      authenticationRepository: AuthenticationRepositoryImpl(
        const FlutterSecureStorage(),
        AuthenticationApi(
          HttpManagement(
            client: http.Client(),
            baseUrl: 'https://api.themoviedb.org/3',
            apiKey: dotenv.env['TMDB_KEY']!,
          ),
        ),
      ),
      connectivityRepository: ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
      child: const MyApp(),
    ),
  );
}

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.connectivityRepository,
    required this.authenticationRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;
  @override
  bool updateShouldNotify(_) {
    throw UnimplementedError();
  }

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
