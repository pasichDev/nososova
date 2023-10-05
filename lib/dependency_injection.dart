import 'package:get_it/get_it.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/server_service.dart';
import 'package:nososova/services/shared_service.dart';
import 'package:nososova/utils/noso/crypto.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MyDatabase>(() => MyDatabase());
  locator.registerLazySingleton<NosoCrypto>(() => NosoCrypto());
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
        nosoCrypto: locator<NosoCrypto>());
  });
  locator.registerLazySingleton(() => AppDataBloc(
      localRepository: locator<LocalRepository>(),
      serverRepository: locator<ServerRepository>()));
}
