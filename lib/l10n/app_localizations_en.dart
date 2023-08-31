import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get overallOnBalance => 'Overall on wallet';

  @override
  String get price => 'Price';

  @override
  String get incoming => 'Incoming';

  @override
  String get outgoing => 'Outgoing';

  @override
  String get wallets => 'Wallet';

  @override
  String get payments => 'Payments';

  @override
  String get node => 'Node';

  @override
  String get myAddresses => 'Addresses';

  @override
  String get notImplemented => 'The function is not implemented';

  @override
  String get newTitle => 'New';

  @override
  String get import => 'Import';

  @override
  String get export => 'Export';

  @override
  String get genNewKeyPair => 'Generate new address';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get selectFilePkw => 'Select file .pkw';

  @override
  String get saveFilePkw => 'Save to file .pkw';

  @override
  String get historyPayments => 'Recent transactions';

  @override
  String get titleScannerCode => 'Qr Code scanner';

  @override
  String get descriptionScannerCode => 'Point the viewfinder at your QR Code';

  @override
  String get foundAddresses => 'Found addresses';

  @override
  String get cancel => 'Cancel';

  @override
  String get addToWallet => 'Add to Wallet';

  @override
  String get titleSetNetwork => 'Network settings';
}
