import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:nososova/models/address.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Addresses])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  Future<List<Address>> getWalletList() async {
    return await select(addresses).get();
  }

  Future<void> addWallet(Address addr) async {
    await into(addresses).insert(addr);
  }

  Future<int> deleteWallet(Address addr) async {
    return await customUpdate(
      'DELETE FROM addresses WHERE hash = :hash',
      variables: [Variable.withString(addr.hash)],
    );
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
