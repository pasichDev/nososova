
// Імпортуйте вашу локальну базу даних та таблиці
import 'package:nososova/database/database.dart';

class LocalRepository {
  final MyDatabase database;

  LocalRepository(this.database);

  Stream<List<Address>> fetchAddress() {
    return Stream.fromFuture(database.getWalletList());
  }

  Future<void> deleteWallet(Address adr) async {
    await database.deleteWallet(adr);
  }

  Future<void> addWallet(Address adr) async {
    await database.addWallet(adr);
  }
}
