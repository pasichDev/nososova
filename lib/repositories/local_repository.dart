import 'package:noso_dart/models/address_object.dart';
import 'package:nososova/database/database.dart';

import '../../models/address_wallet.dart';

class LocalRepository {
  final MyDatabase _database;

  LocalRepository(this._database);

  Stream<List<Address>> fetchAddress() => _database.fetchAddresses();

  Future<void> deleteAddress(Address value) async {
    await _database.deleteWallet(value);
  }

  Future<void> addAddress(AddressObject value) async {
    await _database.addAddress(value);
  }

  Future<void> addAddresses(List<AddressObject> value) async {
    await _database.addAddresses(value);
  }
}
