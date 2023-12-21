class DebugString {
  String time;
  String message;
  DebugType type;

  DebugString(
      {this.time = "", this.message = "", this.type = DebugType.inform});
}

enum DebugType { error, inform, success }
