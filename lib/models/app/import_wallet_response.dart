import '../../database/database.dart';
import '../../utils/const/files_const.dart';
import '../pending_transaction.dart';

class ImportWResponse {
  ActionsFileWallet actionsFileWallet;
  List<Address> address;

  ImportWResponse({
    required this.actionsFileWallet,
    this.address = const [],
  });


}

