import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'app/data/http/httpManagement.dart';
import 'app/data/repository_implementation/account_repository_impl.dart';
import 'app/data/repository_implementation/authentication_repository_impl.dart';
import 'app/data/repository_implementation/connectivity_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/repositories.dart';
import 'app/my_app.dart';

void main() async {
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => AccountRepositoryImpl(),
        ),
        Provider<ConnectivityRepository>(
          create: (context) => ConnectivityRepositoryImpl(
            connectivity: Connectivity(),
            internetChecker: InternetChecker(),
          ),
        ),
        Provider<AuthenticationRepository>(
          create: (context) => AuthenticationRepositoryImpl(
            const FlutterSecureStorage(),
            AuthenticationApi(
              HttpManagement(
                client: http.Client(),
                baseUrl: dotenv.env['BASE_URL']!,
                apiKey: dotenv.env['TMDB_KEY']!,
              ),
            ),
          ),
        )
      ],
      child: const MyApp(),
    ),
  );
}

// class Injector extends InheritedWidget {
//   const Injector({
//     super.key,
//     required super.child,
//     required this.authenticationRepository,
//   });

//   final AuthenticationRepository authenticationRepository;
//   @override
//   bool updateShouldNotify(_) {
//     throw UnimplementedError();
//   }

//   static Injector of(BuildContext context) {
//     final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
//     assert(injector != null, 'Injector could not be found');
//     return injector!;
//   }
// }
