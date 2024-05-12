import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'app/data/http/httpManagement.dart';
import 'app/data/repository_implementation/account_repository_impl.dart';
import 'app/data/repository_implementation/authentication_repository_impl.dart';
import 'app/data/repository_implementation/connectivity_repository_impl.dart';
import 'app/data/repository_implementation/movie_repository_impl.dart';
import 'app/data/repository_implementation/trending_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/data/services/remote/movie_api.dart';
import 'app/data/services/remote/trending_api.dart';
import 'app/domain/repositories/repositories.dart';
import 'app/my_app.dart';
import 'app/presentation/global/controllers/favorite/favorite_controller.dart';
import 'app/presentation/global/controllers/favorite/favorite_state.dart';
import 'app/presentation/global/controllers/session_controller.dart';

void main() async {
  setPathUrlStrategy();
  await dotenv.load();
  final sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  final http = HttpManagement(
    client: Client(),
    baseUrl: dotenv.env['BASE_URL']!,
    apiKey: dotenv.env['TMDB_KEY']!,
  );
  final accountApi = AccountApi(
    http,
    sessionService,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (context) =>
              AccountRepositoryImpl(accountApi, sessionService),
        ),
        Provider<ConnectivityRepository>(
          create: (context) => ConnectivityRepositoryImpl(
              connectivity: Connectivity(), internetChecker: InternetChecker()),
        ),
        Provider<AuthenticationRepository>(
          create: (context) => AuthenticationRepositoryImpl(
              AuthenticationApi(http), sessionService, accountApi),
        ),
        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImpl(TrendingAPI(http)),
        ),
        Provider<MovieRepository>(
          create: (_) => MovieRepositoryImpl(MovieApi(http)),
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
        ChangeNotifierProvider<FavoriteController>(
          create: (context) => FavoriteController(
            FavoriteState.loading(),
            accountRepository: context.read<AccountRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
