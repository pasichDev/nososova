import 'package:get_it/get_it.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/data_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/services/server_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MyDatabase>(() => MyDatabase());
  locator.registerLazySingleton<ServerService>(() => ServerService());
  locator.registerLazySingleton<LocalRepository>(
      () => LocalRepository(locator<MyDatabase>()));
  locator.registerLazySingleton<ServerRepository>(
      () => ServerRepository(locator<ServerService>()));

  locator.registerLazySingleton<DataBloc>(() {
    return DataBloc(
        localRepository: locator<LocalRepository>(),
        serverRepository: locator<ServerRepository>());
  });

  locator
      .registerLazySingleton(() => WalletBloc(dataBloc: locator<DataBloc>()));
  locator.registerLazySingleton(() => AppDataBloc(
      _localRepository: locator<LocalRepository>(),
      _serverRepository: locator<ServerRepository>()));
}
