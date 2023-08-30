// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AddressesTable extends Addresses
    with TableInfo<$AddressesTable, Address> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AddressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _publicKeyMeta =
      const VerificationMeta('publicKey');
  @override
  late final GeneratedColumn<String> publicKey = GeneratedColumn<String>(
      'public_key', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _privateKeyMeta =
      const VerificationMeta('privateKey');
  @override
  late final GeneratedColumn<String> privateKey = GeneratedColumn<String>(
      'private_key', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
      'hash', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [publicKey, privateKey, hash];
  @override
  String get aliasedName => _alias ?? 'addresses';
  @override
  String get actualTableName => 'addresses';
  @override
  VerificationContext validateIntegrity(Insertable<Address> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('public_key')) {
      context.handle(_publicKeyMeta,
          publicKey.isAcceptableOrUnknown(data['public_key']!, _publicKeyMeta));
    } else if (isInserting) {
      context.missing(_publicKeyMeta);
    }
    if (data.containsKey('private_key')) {
      context.handle(
          _privateKeyMeta,
          privateKey.isAcceptableOrUnknown(
              data['private_key']!, _privateKeyMeta));
    } else if (isInserting) {
      context.missing(_privateKeyMeta);
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Address map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Address(
      publicKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}public_key'])!,
      privateKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}private_key'])!,
      hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hash'])!,
    );
  }

  @override
  $AddressesTable createAlias(String alias) {
    return $AddressesTable(attachedDatabase, alias);
  }
}

class Address extends DataClass implements Insertable<Address> {
  final String publicKey;
  final String privateKey;
  final String hash;
  const Address(
      {required this.publicKey, required this.privateKey, required this.hash});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['public_key'] = Variable<String>(publicKey);
    map['private_key'] = Variable<String>(privateKey);
    map['hash'] = Variable<String>(hash);
    return map;
  }

  AddressesCompanion toCompanion(bool nullToAbsent) {
    return AddressesCompanion(
      publicKey: Value(publicKey),
      privateKey: Value(privateKey),
      hash: Value(hash),
    );
  }

  factory Address.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Address(
      publicKey: serializer.fromJson<String>(json['publicKey']),
      privateKey: serializer.fromJson<String>(json['privateKey']),
      hash: serializer.fromJson<String>(json['hash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'publicKey': serializer.toJson<String>(publicKey),
      'privateKey': serializer.toJson<String>(privateKey),
      'hash': serializer.toJson<String>(hash),
    };
  }

  Address copyWith({String? publicKey, String? privateKey, String? hash}) =>
      Address(
        publicKey: publicKey ?? this.publicKey,
        privateKey: privateKey ?? this.privateKey,
        hash: hash ?? this.hash,
      );
  @override
  String toString() {
    return (StringBuffer('Address(')
          ..write('publicKey: $publicKey, ')
          ..write('privateKey: $privateKey, ')
          ..write('hash: $hash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(publicKey, privateKey, hash);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Address &&
          other.publicKey == this.publicKey &&
          other.privateKey == this.privateKey &&
          other.hash == this.hash);
}

class AddressesCompanion extends UpdateCompanion<Address> {
  final Value<String> publicKey;
  final Value<String> privateKey;
  final Value<String> hash;
  final Value<int> rowid;
  const AddressesCompanion({
    this.publicKey = const Value.absent(),
    this.privateKey = const Value.absent(),
    this.hash = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AddressesCompanion.insert({
    required String publicKey,
    required String privateKey,
    required String hash,
    this.rowid = const Value.absent(),
  })  : publicKey = Value(publicKey),
        privateKey = Value(privateKey),
        hash = Value(hash);
  static Insertable<Address> custom({
    Expression<String>? publicKey,
    Expression<String>? privateKey,
    Expression<String>? hash,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (publicKey != null) 'public_key': publicKey,
      if (privateKey != null) 'private_key': privateKey,
      if (hash != null) 'hash': hash,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AddressesCompanion copyWith(
      {Value<String>? publicKey,
      Value<String>? privateKey,
      Value<String>? hash,
      Value<int>? rowid}) {
    return AddressesCompanion(
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
      hash: hash ?? this.hash,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (publicKey.present) {
      map['public_key'] = Variable<String>(publicKey.value);
    }
    if (privateKey.present) {
      map['private_key'] = Variable<String>(privateKey.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressesCompanion(')
          ..write('publicKey: $publicKey, ')
          ..write('privateKey: $privateKey, ')
          ..write('hash: $hash, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $AddressesTable addresses = $AddressesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [addresses];
}
