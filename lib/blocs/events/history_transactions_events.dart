abstract class HistoryTransactionsEvent {}

class FetchHistory extends HistoryTransactionsEvent {
  final String value;
  FetchHistory(this.value);
}

class CleanData extends HistoryTransactionsEvent {}


