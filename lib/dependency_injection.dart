import 'package:get_it/get_it.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/file_repository.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/repositories.dart';
import 'package:nososova/repositories/server_repository.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/file_service.dart';
import 'package:nososova/services/server_service.dart';
import 'package:nososova/services/shared_service.dart';
import 'package:nososova/utils/noso/crypto.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// shared & drift(sql)
  final sharedService = await SharedService().init();
  locator.registerSingleton<SharedService>(sharedService);
  locator.registerLazySingleton<MyDatabase>(() => MyDatabase());

  /// repo && services
  locator.registerLazySingleton<FileService>(() => FileService());
  locator.registerLazySingleton<FileRepository>(
      () => FileRepository(locator<FileService>()));
  locator.registerLazySingleton<ServerService>(() => ServerService());
  locator.registerLazySingleton<ServerRepository>(
      () => ServerRepository(locator<ServerService>()));
  locator.registerLazySingleton<LocalRepository>(
      () => LocalRepository(locator<MyDatabase>()));
  locator.registerLazySingleton<SharedRepository>(
      () => SharedRepository(locator<SharedService>()));
  locator.registerLazySingleton(() => Repositories(
      localRepository: locator<LocalRepository>(),
      serverRepository: locator<ServerRepository>(),
      sharedRepository: locator<SharedRepository>(),
      fileRepository: locator<FileRepository>(),
      nosoCrypto: locator<NosoCrypto>()));

  ///Other utils
  locator.registerLazySingleton<NosoCrypto>(() => NosoCrypto());

  /// Blocs
  locator.registerLazySingleton<WalletBloc>(() => WalletBloc(
        repositories: locator<Repositories>(),
      ));
  locator.registerLazySingleton<AppDataBloc>(() => AppDataBloc(
        repositories: locator<Repositories>(),
      ));
}
