import 'package:nososova/database/database.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

class LocalRepository {
  final MyDatabase _database;

  LocalRepository(this._database);

  Stream<List<Address>> fetchAddress() => _database.fetchAddresses();

  Future<void> deleteWallet(Address adr) async {
    await _database.deleteWallet(adr);
  }

  Future<void> addWallet(Address adr) async {
    await _database.addAddress(adr);
  }
}
