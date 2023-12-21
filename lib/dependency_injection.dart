import 'package:get_it/get_it.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/debug_bloc.dart';
import 'package:nososova/blocs/history_transactions_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/database/database.dart';
import 'package:nososova/repositories/file_repository.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/network_repository.dart';
import 'package:nososova/repositories/repositories.dart';
import 'package:nososova/repositories/shared_repository.dart';
import 'package:nososova/services/explorer_stats_service.dart';
import 'package:nososova/services/file_service.dart';
import 'package:nososova/services/node_service.dart';
import 'package:nososova/services/shared_service.dart';
import 'package:nososova/utils/noso/nosocore.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// shared & drift(sql)
  locator.registerLazySingleton<SharedService>(() => SharedService());
  locator.registerLazySingleton<MyDatabase>(() => MyDatabase());

  /// repo && services
  locator.registerLazySingleton<FileService>(() => FileService());
  locator.registerLazySingleton<ExplorerStatsService>(
      () => ExplorerStatsService());
  locator.registerLazySingleton<FileRepository>(
      () => FileRepository(locator<FileService>()));
  locator.registerLazySingleton<NodeService>(() => NodeService());
  locator.registerLazySingleton<NetworkRepository>(() => NetworkRepository(
      locator<NodeService>(),
      locator<ExplorerStatsService>()));
  locator.registerLazySingleton<LocalRepository>(
      () => LocalRepository(locator<MyDatabase>()));
  locator.registerLazySingleton<SharedRepository>(
      () => SharedRepository(locator<SharedService>()));
  locator.registerLazySingleton(() => Repositories(
      localRepository: locator<LocalRepository>(),
      networkRepository: locator<NetworkRepository>(),
      sharedRepository: locator<SharedRepository>(),
      fileRepository: locator<FileRepository>(),
      nosoCore: locator<NosoCore>()));

  ///Other utils
  locator.registerLazySingleton<NosoCore>(() => NosoCore());

  /// Blocs
  locator.registerLazySingleton<DebugBloc>(() => DebugBloc());
  locator.registerLazySingleton<AppDataBloc>(() => AppDataBloc(
      repositories: locator<Repositories>(), debugBloc: locator<DebugBloc>()));
  locator.registerLazySingleton<WalletBloc>(() => WalletBloc(
      repositories: locator<Repositories>(),
      debugBloc: locator<DebugBloc>(),
      appDataBloc: locator<AppDataBloc>()));
  locator.registerSingleton<HistoryTransactionsBloc>(
    HistoryTransactionsBloc(
      repositories: locator<Repositories>(),
      walletBloc: locator<WalletBloc>(),
    ),
  );

}
