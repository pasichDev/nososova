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
  String get titleInfoNetwork => 'Інформація про вузол';

  @override
  String get debugInfo => 'Інформація про налагодження';

  @override
  String get connections => 'Підключеннь';

  @override
  String get lastBlock => 'Останній Блок';

  @override
  String get pendings => 'В очікуванні';

  @override
  String get branch => 'Гілка';

  @override
  String get version => 'Версія';

  @override
  String get utcTime => 'Час за UTC';

  @override
  String get pingMs => 'мс';

  @override
  String get ping => 'Пінг';

  @override
  String get activeConnect => 'Підключенно';

  @override
  String get connection => 'Підключення..';

  @override
  String get errorConnection => 'Помилка при підключені';
}
