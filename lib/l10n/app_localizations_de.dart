import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get incoming => 'Eingehend';

  @override
  String get outgoing => 'Ausgehend';

  @override
  String get wallets => 'Wallet';

  @override
  String get payments => 'Zahlungen';

  @override
  String get node => 'Node';

  @override
  String get myAddresses => 'Addresses';

  @override
  String get genNewKeyPair => 'Generiere eine neue Adresse';

  @override
  String get scanQrCode => 'Scanne QR Code';

  @override
  String get historyPayments => 'Letzte Transaktionen';

  @override
  String get titleScannerCode => 'QR Code Scanner';

  @override
  String get foundAddresses => 'Adressen gefunden';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get addToWallet => 'Zur Wallet hinzufügen';

  @override
  String get titleInfoNetwork => 'Node Informationen';

  @override
  String get debugInfo => 'Debugging';

  @override
  String get connections => 'Verbindungen';

  @override
  String get lastBlock => 'Letzter Block';

  @override
  String get pendings => 'ausstehend';

  @override
  String get branch => 'Branch';

  @override
  String get version => 'Version';

  @override
  String get utcTime => 'UTC Zeit';

  @override
  String get pingMs => 'ms';

  @override
  String get ping => 'Ping';

  @override
  String get activeConnect => 'Verbunden';

  @override
  String get connection => 'Suche nach einer verfügbaren Node..';

  @override
  String get errorConnection => 'Verbindungsfehler';

  @override
  String get address => 'Adresse';

  @override
  String get keys => 'Schlüssel';

  @override
  String get sendFromAddress => 'Sende von dieser Adresse';

  @override
  String get removeAddress => 'Lösche Adresse aus der Wallet';

  @override
  String get importFile => 'Aus Datei importieren';

  @override
  String get importFileSubtitle => 'Wahlweise eine .pkw oder .nososova Datei';

  @override
  String get exportFile => 'Als Datei exportieren';

  @override
  String get exportFileSubtitle => 'Speichere die Wallet als .pkw oder .nososova Datei';

  @override
  String get fileWallet => 'Wallet-Datei';

  @override
  String get newFormatWalletFileDescrypt => 'Die Anwendung erlaubt es die Wallet in einem sicheren format zu speichern.';

  @override
  String get searchAddressResult => 'Adresse gefunden';

  @override
  String get billAction => 'Stelle eine Rechnung an diese Adresse';

  @override
  String get addressesAdded => 'Füge weitere Adressen der Wallet hinzu';

  @override
  String get settings => 'Einstellungen';

  @override
  String get sync => 'Synchronisation';

  @override
  String get information => 'Information';

  @override
  String get masternodes => 'Masternodes';

  @override
  String get blocksRemaining => 'Ausstehende Blocks';

  @override
  String get daysUntilNextHalving => 'Tage bis zum nächsten Halving';

  @override
  String get numberOfMinedCoins => 'Anzahl an mined Coins';

  @override
  String get coinsLocked => 'Gesperrte Coins';

  @override
  String get marketcap => 'Noso Marketcap';

  @override
  String get tvl => 'Gesamtwert der gesperrten Coins';

  @override
  String get maxPriceStory => 'Maximaler Preis pro Geschichte';

  @override
  String get activeNodes => 'Active Nodes';

  @override
  String get tmr => 'Gesamte Masternode Belohnung';

  @override
  String get nbr => 'Node Block Belohnung';

  @override
  String get nr24 => '24 Stunden Belohnung';

  @override
  String get nr7 => '7 Tage Belohnung';

  @override
  String get nr30 => '30 Tage Belohnung';

  @override
  String get nosoPrice => 'Noso Preis';

  @override
  String get launched => 'Läuft';

  @override
  String get available => 'Verfügbar';

  @override
  String get masternode => 'Masternode';

  @override
  String get empty => 'Leer';

  @override
  String get emptyNodesError => 'Es sind keine Adressen verfügbar, um eine Masternde zu starten..';

  @override
  String get importKeysPair => 'Importiere Schlüsselpaar';

  @override
  String get catHistoryTransaction => 'Transaktionsverlauf';

  @override
  String get transactionInfo => 'Information zu Transaktionen';

  @override
  String get block => 'Block';

  @override
  String get orderId => 'Order ID';

  @override
  String get receiver => 'Empfänger';

  @override
  String get commission => 'Kommission';

  @override
  String get openToExplorer => 'Im Explorer ansehen';

  @override
  String get shareTransaction => 'Transaktion teilen';

  @override
  String get message => 'Nachricht';

  @override
  String get editCustom => 'Name ändern';

  @override
  String get errorLoading => 'Serverfehler';

  @override
  String get catActionAddress => 'Adressaktion';

  @override
  String get customNameAdd => 'Alias setzen';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get sender => 'Sender';

  @override
  String get confirmDelete => 'Bestätige das Entfernen der Adresse';

  @override
  String get aliasNameAddress => 'Alias ändern';

  @override
  String get alias => 'Alias';

  @override
  String get consensusCheck => 'Konsens gefunden';

  @override
  String get save => 'Speichern';

  @override
  String get nodeType => 'Node Typ';

  @override
  String get status => 'Status';

  @override
  String get balance => 'Kontostand';

  @override
  String get actionWallet => 'Wallet Actions';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get createPayment => 'Zahlung erstellen';

  @override
  String get amount => 'Menge';

  @override
  String get send => 'Senden';

  @override
  String get chanceNode => 'Node ändern';

  @override
  String get viewQr => 'QR Code zeigen';

  @override
  String get infoTotalPriceUst => 'Kontostand in USDT';

  @override
  String get updateInfo => 'Information updaten';

  @override
  String get copyAddress => 'Adresse kopieren';

  @override
  String get informMyNodes => 'Status meiner Nodes';

  @override
  String get getKeysPair => 'Schlüssel anzeigen';

  @override
  String get reward => 'Belohnen';

  @override
  String get online => 'Online';

  @override
  String get sellAddress => 'Wählen Sie eine Adresse aus';

  @override
  String get offline => 'Offline';

  @override
  String get emptyListAddress => 'Erstelle eine neue Adresse';

  @override
  String get aliasMessage => 'Der Alias kann zwischen 3 und 32 Zeichen lang sein. Vergiss nicht, dass für die Einrichtung eines Alias eine Transaktionsgebühr erhoben wird.';

  @override
  String get errorNoFoundCoinsTransaction => 'Der Kontostand ist zu niedrig für diese Transaktion';

  @override
  String get errorInformationIncorrect => 'Die Transaktionsinformationen sind nicht korrekt';

  @override
  String get errorImportAddresses => 'Adresse ist bereits vorhanden und konnte nicht hinzugefügt werden';

  @override
  String get errorDefaultErrorAlias => 'Fehler beim Versuch einen Alias zu setzten';

  @override
  String get priceInfoErrorServer => 'Preisinformation zur Zeit nicht verfügbar';

  @override
  String get errorEmptyHistoryTransactions => 'Es wurde kein Transaktionsverlauf für diese Adresse gefunden';

  @override
  String get errorNoValidAddress => 'Fehler; ungültige Adresse';

  @override
  String get errorNoSync => 'Die App is nicht mit dem Mainnet synchronisiert';

  @override
  String get errorAddressBlock => 'Adresse blockiert, Zahlung wurde abgebrochen';

  @override
  String get errorAddressFound => 'Empfängeradresse existiert nicht';

  @override
  String get sendProcess => 'Zahlung wartet auf Bestätigung';

  @override
  String get errorSendOrderDefault => 'Fehler beim Senden der Transaktion, versuche es später erneut';

  @override
  String get warringMessageSetAlias => 'Diese Funktion ist nur einmal verfügbar';

  @override
  String get successSetAlias => 'Die Anfrage war erfolgreich und wurde ausgeführt';

  @override
  String get errorEmptyListWallet => 'Diese Datei enthält keine Adressen';

  @override
  String get errorNotSupportedWallet => 'Diese Datei ist nicht unterstützt';

  @override
  String get errorLastTime => 'Ваша час відстає, оновіть ваш час';

  @override
  String get unknownError => 'Ein Fehler ist passiert';
}
