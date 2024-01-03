
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:map_flutter/bloc_observer.dart';
import 'package:map_flutter/dio_service/dio_provider.dart';
import 'package:map_flutter/dio_service/dio_service.dart';
import 'package:map_flutter/dio_service/dio_service_impl.dart';
import 'package:map_flutter/global_cubit/global_cubit.dart';
import 'package:map_flutter/home/data_source/remote/home_data_source.dart';
import 'package:map_flutter/home/data_source/remote/home_data_source_impl.dart';
import 'package:map_flutter/home/data_source/repository/home_repository.dart';
import 'package:map_flutter/home/data_source/repository/home_repository_impl.dart';
import 'package:map_flutter/home/manager/home_cubit.dart';
import 'package:map_flutter/network_service/network_provider.dart';
import 'package:map_flutter/network_service/network_service.dart';
import 'package:map_flutter/network_service/network_service_impl.dart';
import 'package:map_flutter/repository/global/global_repository.dart';
import 'package:map_flutter/repository/global/global_repository_impl.dart';
import 'package:map_flutter/shared_preferences/preference_helper.dart';
import 'package:map_flutter/shared_preferences/preferences_provider.dart';


final serviceLocator = GetIt.instance;

Future initApp() async {
  Bloc.observer = MyBlocObserver();

  /// ui cubit

  serviceLocator.registerFactory(
        () => GlobalCubit(
      globalRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => HomeCubit(
      homeRepository: serviceLocator(),
    ),
  );




  /// repositories
  serviceLocator.registerLazySingleton<GlobalRepository>(
    () => GlobalRepositoryImpl(
      helper: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeDataSource:  serviceLocator(),
      networkService: serviceLocator(),
    ),
  );







  /// others

  serviceLocator.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(
      dioService: serviceLocator(),
    ),
  );


  /// services
  serviceLocator.registerLazySingleton<PreferenceHelper>(
    () => PreferenceHelper(
      preferencesProvider: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DioService>(
    () => DioServiceImpl(
      dioProvider: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<NetworkService>(
    () => NetworkServiceImpl(
      networkProvider: serviceLocator(),
    ),
  );

  /// providers
  serviceLocator.registerLazySingleton(
    () => SharedPreferencesProvider.instance,
  );
  serviceLocator.registerLazySingleton<DioProvider>(
    () => DioProvider.instance,
  );
  serviceLocator.registerLazySingleton<NetworkProvider>(
    () => NetworkProvider.instance,
  );
}
