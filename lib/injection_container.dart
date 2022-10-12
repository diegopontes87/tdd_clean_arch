import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Features - Number Trivia
  // Bloc
  getIt.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTriviaUseCase: getIt(),
      inputConverter: getIt(),
      getRandomNumberTriviaUseCase: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetConcreteNumberTriviaUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTriviaUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImplementation(
      localDataSource: getIt(),
      networkInfo: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImplementation(client: getIt()),
  );

  getIt.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImplementation(sharedPreferences: getIt()),
  );

  // Core
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation(getIt()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => DataConnectionChecker());
}
