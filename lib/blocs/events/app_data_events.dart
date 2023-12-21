

abstract class AppDataEvent {}

class InitialConnect extends AppDataEvent {}

class FetchNodesList extends AppDataEvent {
  FetchNodesList();
}

class ReconnectSeed extends AppDataEvent {
  final bool lastNodeRun;
  ReconnectSeed(this.lastNodeRun);
}

class SyncResult extends AppDataEvent {
  final bool success;
  SyncResult(this.success);
}