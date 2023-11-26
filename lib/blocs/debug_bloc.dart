import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:nososova/blocs/events/debug_events.dart';

import '../models/app/debug.dart';

class DebugState {
  final List<DebugString> debugList;

  DebugState({
    List<DebugString>? debugList,
  }) : debugList = debugList ?? [];

  DebugState copyWith({
    List<DebugString>? debugList,
  }) {
    return DebugState(
      debugList: debugList ?? this.debugList,
    );
  }
}

class DebugBloc extends Bloc<DebugEvent, DebugState> {
  DebugBloc() : super(DebugState()) {
    on<AddStringDebug>(_addToDebug);
  }

  _addToDebug(event, emit) {
    var list = state.debugList;
    DateTime now = DateTime.now();
    list.add(DebugString(time: "${now.hour}:${now.minute}:${now.second.toString().padLeft(2, '0')}", message: event.value));

    emit(state.copyWith(debugList: list));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
