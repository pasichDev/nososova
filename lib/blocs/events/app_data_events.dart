
import '../../database/database.dart';
import '../../models/pending_transaction.dart';
import '../wallet_bloc.dart';
abstract class AppDataEvent {}

class InitialConnect extends AppDataEvent {}

class FetchNodesList extends AppDataEvent {
  FetchNodesList();
}

class ReconnectSeed extends AppDataEvent {
  ReconnectSeed();
}
