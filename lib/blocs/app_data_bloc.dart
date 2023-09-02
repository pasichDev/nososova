import 'package:bloc/bloc.dart';
import 'package:nososova/network/models/node_info.dart';
import 'package:nososova/network/models/seed.dart';
import 'package:nososova/repositories/local_repository.dart';
import 'package:nososova/repositories/server_repository.dart';

abstract class AppDataEvent {}

class StartNode extends AppDataEvent {}

class AppDataState {
  final NodeInfo nodeInfo;
  final Seed seedActive;

  AppDataState({NodeInfo? nodeInfo, Seed? seedActive})
      : nodeInfo = nodeInfo ?? NodeInfo(seed: Seed()),
        seedActive = seedActive ?? Seed();
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  final ServerRepository _serverRepository;
  final LocalRepository _localRepository;
  AppDataBloc({
    required ServerRepository serverRepository,
    required LocalRepository localRepository,
  })  : _serverRepository = serverRepository,
        _localRepository = localRepository,
        super(AppDataState()) {
    on<StartNode>((event, emit) async {
      final seed = await _serverRepository.listenNodes();
      final nodeInfo = await _serverRepository.fetchNode(seed);
      emit(AppDataState(seedActive: seed, nodeInfo: nodeInfo));
    });
  }
}
