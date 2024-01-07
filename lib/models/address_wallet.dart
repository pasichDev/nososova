import 'package:drift/drift.dart';
import 'package:noso_dart/models/address_object.dart';

@DataClassName('Address')
class Address extends AddressObject {
  Address({
    required String hash,
    String? custom,
    required String publicKey,
    required String privateKey,
    double balance = 0,
    double pending = 0,
    int score = 0,
    int lastOP = 0,
    bool isLocked = false,
    double incoming = 0,
    double outgoing = 0,
    double rewardDay = 0,
    bool nodeAvailable = false,
    bool nodeStatusOn = false,
  }) : super(
          hash: hash,
          custom: custom,
          publicKey: publicKey,
          privateKey: privateKey,
          balance: balance,
          pending: pending,
          score: score,
          lastOP: lastOP,
          isLocked: isLocked,
          incoming: incoming,
          outgoing: outgoing,
          rewardDay: rewardDay,
          nodeAvailable: nodeAvailable,
          nodeStatusOn: nodeStatusOn,
        );
}
