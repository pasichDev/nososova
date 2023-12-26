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

  /// A method that adds an event to the console
  _addToDebug(event, emit) {
    final DateTime now = DateTime.now();
    var list = state.debugList;
    list = list.length >= 100 ? [] : list;

    list.add(DebugString(
        time:
            "${now.hour}:${now.minute}:${now.second.toString().length < 2 ? now.second : now.second.toString().padLeft(2, '0')}",
        message: event.value,
        type: event.type));

    emit(state.copyWith(debugList: list));
  }
}
