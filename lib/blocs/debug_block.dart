import 'package:bloc/bloc.dart';

abstract class DebugEvent {}

class AddLogString extends DebugEvent {
  final String value;

  AddLogString(this.value);
}

class DebugState {
  final List<String> debugInfo;

  DebugState({required this.debugInfo});

  DebugState copyWith({List<String>? debugInfo}) {
    return DebugState(
      debugInfo: debugInfo ?? this.debugInfo,
    );
  }
}

class DebugBloc extends Bloc<DebugEvent, DebugState> {
  DebugBloc() : super(DebugState(debugInfo: [])) {
    on<AddLogString>((event, emit) async {
      final updatedDebugInfo = List<String>.from(state.debugInfo);
      updatedDebugInfo.add(event.value);

      emit(state.copyWith(debugInfo: updatedDebugInfo));
    });
  }
}
