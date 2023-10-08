import '../../utils/const/files_const.dart';
import '../../utils/noso/src/address_object.dart';

class ImportWResponse {
  ActionsFileWallet actionsFileWallet;
  List<Address> address;

  ImportWResponse({
    required this.actionsFileWallet,
    this.address = const [],
  });
}
