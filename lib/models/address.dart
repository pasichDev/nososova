import 'package:drift/drift.dart';

@DataClassName('Address')
class Addresses extends Table {
  TextColumn get publicKey => text().withLength(min: 1, max: 100)();
  TextColumn get privateKey => text().withLength(min: 1, max: 100)();
  TextColumn get hash => text().withLength(min: 1, max: 100)();

}
