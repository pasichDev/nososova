import 'app_localizations.dart';

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get overallOnBalance => 'Загалом на балансі';

  @override
  String get price => 'Вартість';

  @override
  String get incoming => 'Вхідні';

  @override
  String get outgoing => 'Вихідні';

  @override
  String get wallets => 'Гаманці';

  @override
  String get payments => 'Платежі';

  @override
  String get node => 'Вузол';

  @override
  String get myWallets => 'Мої гаманці';

  @override
  String get notImplemented => 'Функція не реалізована';

  @override
  String get newTitle => 'Новий';

  @override
  String get import => 'Імпорт';

  @override
  String get export => 'Експорт';

  @override
  String get genNewKeyPair => 'Згенерувати нову пару ключів';

  @override
  String get scanQrCode => 'Відскануйте QR-код';

  @override
  String get selectFilePkw => 'Виберіть файл .pkw';

  @override
  String get saveFilePkw => 'Зберегти у файл .pkw';
}
