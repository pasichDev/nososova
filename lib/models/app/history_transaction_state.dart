import '../../utils/status_api.dart';
import '../apiExplorer/transaction_history.dart';

class HistoryTransactionWState {
  List<TransactionHistory> transactions;
  ApiStatus apiStatus = ApiStatus.loading;
  double totalOutgoing = 0;
  double totalIncoming = 0;

  HistoryTransactionWState({
    this.transactions = const [],
    this.apiStatus = ApiStatus.loading,
  });

  HistoryTransactionWState copyWith({
    List<TransactionHistory>? transactions,
    ApiStatus? apiStatus,
  }) {
    return HistoryTransactionWState(
      transactions: transactions ?? this.transactions,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }
}
