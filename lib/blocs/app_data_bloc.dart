import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nososova/network/models/node_info.dart';
import 'package:nososova/network/models/seed.dart';

// Події та стан для глобальних даних
abstract class AppDataEvent {}

class UpdateServerInfoEvent extends AppDataEvent {
  final NodeInfo nodeInfo;
  UpdateServerInfoEvent(this.nodeInfo);
}

class AppDataState {
  final NodeInfo nodeInfo;

  AppDataState({required this.nodeInfo});
}

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppDataBloc() : super(AppDataState(nodeInfo: NodeInfo(seed: Seed())));

  @override
  Stream<AppDataState> mapEventToState(AppDataEvent event) async* {
    if (event is UpdateServerInfoEvent) {
      yield AppDataState(nodeInfo: event.nodeInfo);
    }
  }
}
