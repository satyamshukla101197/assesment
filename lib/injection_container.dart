import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supdup/core/config/db_provider.dart';
import 'package:supdup/core/config/my_shared_pref.dart';
import 'package:supdup/features/data/client/client.dart';
import 'package:supdup/features/domain/use_cases/data_use_case.dart';

import 'core/network/network_info.dart';
import 'features/data/datasource/local_datasource.dart';
import 'features/data/datasource/remote_datasource.dart';
import 'features/data/repositories/repository_impl.dart';
import 'features/domain/repositories/repository.dart';
import 'features/presentation/pages/second_screen/second_screen_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => SecondScreenBloc(dataUseCase: sl()));
  // usecases
  sl.registerLazySingleton(() => DataUseCase(sl()));
  // repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(
      localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  // No access to DB provider, job of LocalDataSource to choose which source
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(mySharedPref: sl(), dbProvider: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));

  // initializing dio
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(request: true, responseBody: true));

  // External
  final dbProvider = DBProvider();
  await dbProvider.getInstance();

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DBProvider>(() => dbProvider);
  sl.registerLazySingleton(() => RestClient(dio, sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
