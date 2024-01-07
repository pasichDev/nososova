import 'package:drift/drift.dart';

import '../../models/address_wallet.dart';

@UseRowClass(Address)
class Addresses extends Table {

  TextColumn get publicKey => text().withLength(min: 1, max: 100)();
  TextColumn get privateKey => text().withLength(min: 1, max: 100)();
  TextColumn get hash => text().withLength(min: 1, max: 100)();
  TextColumn? get custom => text().nullable().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {hash};
}
