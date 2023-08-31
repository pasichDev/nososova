import 'app_localizations.dart';

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get overallOnBalance => 'Загалом в гаманці';

  @override
  String get price => 'Вартість';

  @override
  String get incoming => 'Вхідні';

  @override
  String get outgoing => 'Вихідні';

  @override
  String get wallets => 'Гаманець';

  @override
  String get payments => 'Платежі';

  @override
  String get node => 'Вузол';

  @override
  String get myAddresses => 'Адреси';

  @override
  String get notImplemented => 'Функція не реалізована';

  @override
  String get newTitle => 'Новий';

  @override
  String get import => 'Імпорт';

  @override
  String get export => 'Експорт';

  @override
  String get genNewKeyPair => 'Згенерувати нову адресу';

  @override
  String get scanQrCode => 'Відскануйте QR-код';

  @override
  String get selectFilePkw => 'Виберіть файл .pkw';

  @override
  String get saveFilePkw => 'Зберегти у файл .pkw';

  @override
  String get historyPayments => 'Останні транзакції';

  @override
  String get titleScannerCode => 'Сканер Qr-коду';

  @override
  String get descriptionScannerCode => 'Наведіть видошукач на свій QR-код';

  @override
  String get foundAddresses => 'Знайдені адреси';

  @override
  String get cancel => 'Відмінити';

  @override
  String get addToWallet => 'Додати в гаманець';

  @override
  String get titleSetNetwork => 'Налаштування мережі';
}
