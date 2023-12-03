

abstract class AppDataEvent {}

class InitialConnect extends AppDataEvent {}

class FetchNodesList extends AppDataEvent {
  FetchNodesList();
}

class ReconnectSeed extends AppDataEvent {
  final bool lastNodeRun;
  ReconnectSeed(this.lastNodeRun);
}

class SendOrder extends AppDataEvent {
  final bool lastNodeRun;
  SendOrder(this.lastNodeRun);
}
