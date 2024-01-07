import '../../models/address_wallet.dart';
import '../../utils/files_const.dart';

class ImportWResponse {
  ActionsFileWallet actionsFileWallet;
  List<Address> address;
  String value;

  ImportWResponse(
      {required this.actionsFileWallet,
      this.address = const [],
      this.value = ''});
}
