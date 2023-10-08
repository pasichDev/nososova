import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:nososova/database/address.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../utils/noso/src/address_object.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Addresses])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  Stream<List<Address>> fetchAddresses() => select(addresses).watch();

  Future<void> addAddress(Address value) async {
    final insertable = AddressesCompanion(
      publicKey: Value(value.publicKey),
      privateKey: Value(value.privateKey),
      hash: Value(value.hash),
    );

    await into(addresses).insert(insertable);
  }

  Future<void> deleteWallet(Address value) async {
    final insertable = AddressesCompanion(
      publicKey: Value(value.publicKey),
      privateKey: Value(value.privateKey),
      hash: Value(value.hash),
    );
    await delete(addresses).delete(insertable);
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
