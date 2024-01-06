import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get incoming => 'Входящие';

  @override
  String get outgoing => 'Исходящие';

  @override
  String get wallets => 'Кошелёк';

  @override
  String get payments => 'Платежи';

  @override
  String get node => 'Нода';

  @override
  String get myAddresses => 'Адреса';

  @override
  String get genNewKeyPair => 'Создать новый адрес';

  @override
  String get scanQrCode => 'Сканировать QR код';

  @override
  String get historyPayments => 'История транзакций';

  @override
  String get titleScannerCode => 'QR Сканнер';

  @override
  String get foundAddresses => 'Найти адрес';

  @override
  String get cancel => 'Отмена';

  @override
  String get addToWallet => 'Добавить в кошелёк';

  @override
  String get titleInfoNetwork => 'Подключение к сети.';

  @override
  String get debugInfo => 'Отладка';

  @override
  String get connections => 'Соединения';

  @override
  String get lastBlock => 'Блок:';

  @override
  String get pendings => 'В процессе';

  @override
  String get branch => 'Ветвь';

  @override
  String get version => 'Версия:';

  @override
  String get utcTime => 'Время (UTC):';

  @override
  String get pingMs => 'мс';

  @override
  String get ping => 'Пинг';

  @override
  String get activeConnect => 'Подключено';

  @override
  String get connection => 'Поиск доступной ноды...';

  @override
  String get errorConnection => 'Ошибка при подключении';

  @override
  String get address => 'Адрес';

  @override
  String get keys => 'Ключи';

  @override
  String get sendFromAddress => 'Отправить монеты с этого адреса';

  @override
  String get removeAddress => 'Удалить адрес из кошелька';

  @override
  String get importFile => 'Импорт из файла';

  @override
  String get importFileSubtitle => 'Выберите файл кошелька: .pkw или .nososova.';

  @override
  String get exportFile => 'Экспорт в файл';

  @override
  String get exportFileSubtitle => 'Сохранить кошелёк в файл .pkw или .nososova';

  @override
  String get fileWallet => 'Файл кошелька';

  @override
  String get newFormatWalletFileDescrypt => 'Наше приложение предлагает вам возможность хранить ваш кошелек в самом безопасном формате.';

  @override
  String get searchAddressResult => 'Адрес найден';

  @override
  String get billAction => 'Счёт на этот адрес';

  @override
  String get addressesAdded => 'Добавьте новые адреса в свой кошелек';

  @override
  String get settings => 'Настройки';

  @override
  String get sync => 'Синхронизация';

  @override
  String get information => 'Информация';

  @override
  String get masternodes => 'Мастерноды';

  @override
  String get blocksRemaining => 'Осталось блоков';

  @override
  String get daysUntilNextHalving => 'Дней до следующего Халвинга';

  @override
  String get numberOfMinedCoins => 'Количество добытых монет';

  @override
  String get coinsLocked => 'Монет заблокировано';

  @override
  String get marketcap => 'Капитализация NOSO';

  @override
  String get tvl => 'Всего заблокировано';

  @override
  String get maxPriceStory => 'Максимальная цена';

  @override
  String get activeNodes => 'Активные ноды';

  @override
  String get tmr => 'Общая награда';

  @override
  String get nbr => 'Награда за блок';

  @override
  String get nr24 => 'Вознаграждение за сутки';

  @override
  String get nr7 => 'Вознаграждение за неделю';

  @override
  String get nr30 => 'Вознаграждение за 30 дней';

  @override
  String get nosoPrice => 'Стоимость NOSO';

  @override
  String get launched => 'Запущено';

  @override
  String get available => 'Доступно';

  @override
  String get masternode => 'Мастернода';

  @override
  String get empty => 'Пусто';

  @override
  String get emptyNodesError => 'У Вас нет подходящих адресов для запуска Мастерноды.';

  @override
  String get importKeysPair => 'Импорт из Key Pair';

  @override
  String get catHistoryTransaction => 'История транзакций';

  @override
  String get transactionInfo => 'Данные транзакции';

  @override
  String get block => 'Блок:';

  @override
  String get orderId => 'Order ID';

  @override
  String get receiver => 'Получатель';

  @override
  String get commission => 'Комиссия';

  @override
  String get openToExplorer => 'Открыть в Explorer-e';

  @override
  String get shareTransaction => 'Поделиться';

  @override
  String get message => 'Сообщение';

  @override
  String get editCustom => 'Задать псевдоним';

  @override
  String get errorLoading => 'Ошибка';

  @override
  String get catActionAddress => 'Что Вы хотите сделать?';

  @override
  String get customNameAdd => 'Задать псевдоним';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get sender => 'Отправитель';

  @override
  String get confirmDelete => 'Подтвердить удаление адреса';

  @override
  String get aliasNameAddress => 'Изменить псевдоним';

  @override
  String get alias => 'Псевдоним';

  @override
  String get consensusCheck => 'Консенсус';

  @override
  String get save => 'Сохранить';

  @override
  String get nodeType => 'Тип:';

  @override
  String get status => 'Статус:';

  @override
  String get balance => 'Баланс';

  @override
  String get actionWallet => 'Что Вы хотите сделать?';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get createPayment => 'Сделать перевод';

  @override
  String get amount => 'Количество';

  @override
  String get send => 'Отправить';

  @override
  String get chanceNode => 'Сменить ноду';

  @override
  String get viewQr => 'Открыть QR код';

  @override
  String get infoTotalPriceUst => 'Баланс в USDT';

  @override
  String get updateInfo => 'Обновить данные';

  @override
  String get copyAddress => 'Скопировать адрес';

  @override
  String get informMyNodes => 'Ваши мастерноды';

  @override
  String get getKeysPair => 'View keys';

  @override
  String get reward => 'Reward';

  @override
  String get online => 'Online';

  @override
  String get sellAddress => 'Выберите адрес';

  @override
  String get offline => 'Offline';

  @override
  String get emptyListAddress => 'Создать или сгенерировать новые адреса';

  @override
  String get aliasMessage => 'Псевдоним может быть длиной от 3 до 32 символов. Также не забывайте, что за создание псевдонима взимается комиссия.';

  @override
  String get errorNoFoundCoinsTransaction => 'Недостаточно монет';

  @override
  String get errorInformationIncorrect => 'Некоректная информация';

  @override
  String get errorImportAddresses => 'Адреса не добавлены, так как обнаружены дубликаты';

  @override
  String get errorDefaultErrorAlias => 'Ошибка при попытке установить псевдоним';

  @override
  String get priceInfoErrorServer => 'Информация о цене недоступна';

  @override
  String get errorEmptyHistoryTransactions => 'По этому адресу транзакций не найдено';

  @override
  String get errorNoValidAddress => 'Ошибка, неверный адрес';

  @override
  String get errorNoSync => 'Приложение не синхронизировано с основной сетью';

  @override
  String get errorAddressBlock => 'Адрес заблокирован, платеж отменен';

  @override
  String get errorAddressFound => 'Получатель не существует';

  @override
  String get sendProcess => 'Платеж ожидает подтверждения';

  @override
  String get errorSendOrderDefault => 'Ошибка при отправке платежа. Повторите попытку позже.';

  @override
  String get warringMessageSetAlias => 'Операция доступна только один раз';

  @override
  String get successSetAlias => 'Ваш запрос обработан и успешно выполнен';

  @override
  String get errorEmptyListWallet => 'Этот файл не содержит адреса';

  @override
  String get errorNotSupportedWallet => 'Этот файл не поддерживается';

  @override
  String get unknownError => 'Произошла ошибка';
}
