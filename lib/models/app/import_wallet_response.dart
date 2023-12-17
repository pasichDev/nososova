import '../../utils/const/files_const.dart';
import '../../utils/noso/model/address_object.dart';

class ImportWResponse {
  ActionsFileWallet actionsFileWallet;
  List<Address> address;
  String value;

  ImportWResponse(
      {required this.actionsFileWallet,
      this.address = const [],
      this.value = ''});
}
