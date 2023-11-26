abstract class DebugEvent {}

class AddStringDebug extends DebugEvent {
  final String value;
  AddStringDebug(this.value);
}
