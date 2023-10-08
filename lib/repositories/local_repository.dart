import 'package:nososova/database/database.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

class LocalRepository {
  final MyDatabase _database;

  LocalRepository(this._database);

  Stream<List<Address>> fetchAddress() => _database.fetchAddresses();

  Future<void> deleteAddress(Address value) async {
    await _database.deleteWallet(value);
  }

  Future<void> addAddress(Address value) async {
    await _database.addAddress(value);
  }

  Future<void> addAddresses(List<Address> value) async {
    await _database.addAddresses(value);
  }
}
