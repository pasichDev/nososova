import 'package:nososova/database/database.dart';

class LocalRepository {
  final MyDatabase _database;

  LocalRepository(this._database);

  Stream<List<Address>> fetchAddress() {
    return Stream.fromFuture(_database.getWalletList());
  }

  Future<void> deleteWallet(Address adr) async {
    await _database.deleteWallet(adr);
  }

  Future<void> addWallet(Address adr) async {
    await _database.addWallet(adr);
  }
}
