import 'package:nososova/models/app/debug.dart';

abstract class DebugEvent {}

class AddStringDebug extends DebugEvent {
  final String value;
  final DebugType type;

  AddStringDebug(this.value, [this.type = DebugType.inform]);
}
