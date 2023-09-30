import 'package:get_it/get_it.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/debug_block.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/server_service.dart';
import 'package:nososova/services/shared_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MyDatabase>(() => MyDatabase());
  locator.registerLazySingleton<ServerService>(() => ServerService());
  locator.registerLazySingleton<LocalRepository>(
      () => LocalRepository(locator<MyDatabase>()));
  locator.registerLazySingleton<ServerRepository>(
      () => ServerRepository(locator<ServerService>()));
  locator.registerLazySingleton<SharedRepository>(
      () => SharedRepository(locator<SharedService>()));

  locator.registerLazySingleton<WalletBloc>(() {
    return WalletBloc(
        localRepository: locator<LocalRepository>(),
        serverRepository: locator<ServerRepository>());
  });
  locator.registerLazySingleton(() => DebugBloc());
  locator.registerLazySingleton(() => AppDataBloc(
      localRepository: locator<LocalRepository>(),
      serverRepository: locator<ServerRepository>(),
      debugBloc: locator<DebugBloc>()));
}
