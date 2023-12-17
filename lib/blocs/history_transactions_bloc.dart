import 'package:bloc/bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/repositories/repositories.dart';

import '../models/apiExplorer/transaction_history.dart';
import '../models/responses/response_api.dart';
import '../utils/status_api.dart';
import 'events/history_transactions_events.dart';

class HistoryTransactionsBState {
  final List<TransactionHistory> transactions;
  final ApiStatus apiStatus;

  HistoryTransactionsBState({
    List<TransactionHistory>? transactions,
    ApiStatus? apiStatus,
  })  : transactions = transactions ?? [],
        apiStatus = apiStatus ?? ApiStatus.loading;

  HistoryTransactionsBState copyWith({
    List<TransactionHistory>? transactions,
    ApiStatus? apiStatus,
  }) {
    return HistoryTransactionsBState(
        transactions: transactions ?? this.transactions,
        apiStatus: apiStatus ?? this.apiStatus);
  }
}

class HistoryTransactionsBloc
    extends Bloc<HistoryTransactionsEvent, HistoryTransactionsBState> {
  final WalletBloc walletBloc;
  final Repositories _repositories;

  HistoryTransactionsBloc({
    required Repositories repositories,
    required this.walletBloc,
  })  : _repositories = repositories,
        super(HistoryTransactionsBState()) {
    on<FetchHistory>(_fetchHistory);
    on<CleanData>(_cleanData);
  }

  factory HistoryTransactionsBloc.create(
      Repositories repositories, WalletBloc walletBloc) {
    return HistoryTransactionsBloc(
      repositories: repositories,
      walletBloc: walletBloc,
    );
  }

  void _fetchHistory(event, emit) async {
    add(CleanData());

    ResponseApi response = await _repositories.networkRepository
        .fetchHistoryTransactions(event.value);

    if (response.value != null) {
      emit(state.copyWith(
          transactions: response.value, apiStatus: ApiStatus.connected));
    } else {
      emit(state.copyWith(apiStatus: ApiStatus.error));
    }
  }

  void _cleanData(event, emit) async {
    emit(state.copyWith(transactions: [], apiStatus: ApiStatus.loading));
  }
}
