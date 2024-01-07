import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get genNewKeyPair => 'Generate new address';

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get historyPayments => 'Recent transactions';

  @override
  String get titleScannerCode => 'Qr Code scanner';

  @override
  String get foundAddresses => 'Found addresses';

  @override
  String get cancel => 'Cancel';

  @override
  String get addToWallet => 'Add to Wallet';

  @override
  String get titleInfoNetwork => 'Node info';

  @override
  String get debugInfo => 'Debugging';

  @override
  String get connections => 'Connections';

  @override
  String get lastBlock => 'Last Block';

  @override
  String get pendings => 'Pendings';

  @override
  String get branch => 'Branch';

  @override
  String get version => 'Version';

  @override
  String get utcTime => 'UTC Time';

  @override
  String get pingMs => 'ms';

  @override
  String get ping => 'Ping';

  @override
  String get activeConnect => 'Connected';

  @override
  String get connection => 'Searching for an available node..';

  @override
  String get errorConnection => 'Connection error';

  @override
  String get address => 'Address';

  @override
  String get keys => 'Keys';

  @override
  String get sendFromAddress => 'Send from this address';

  @override
  String get removeAddress => 'Remove address from wallet';

  @override
  String get importFile => 'Import from File';

  @override
  String get importFileSubtitle => 'Choose a wallet file in .pkw or .nososova';

  @override
  String get exportFile => 'Export to File';

  @override
  String get exportFileSubtitle => 'Save the wallet file in .pkw or .nososova';

  @override
  String get fileWallet => 'Wallet file';

  @override
  String get newFormatWalletFileDescrypt => 'Our exciting application offers you the opportunity to store your wallet in the most secure format';

  @override
  String get searchAddressResult => 'Address found';

  @override
  String get billAction => 'Bill to this address';

  @override
  String get addressesAdded => 'Add new addresses to your wallet';

  @override
  String get settings => 'Settings';

  @override
  String get sync => 'Synchronization';

  @override
  String get information => 'Information';

  @override
  String get masternodes => 'Masternodes';

  @override
  String get blocksRemaining => 'Blocks Remaining';

  @override
  String get daysUntilNextHalving => 'Days until Next Halving';

  @override
  String get numberOfMinedCoins => 'Number of mined coins';

  @override
  String get coinsLocked => 'Coins Locked';

  @override
  String get marketcap => 'Noso Marketcap';

  @override
  String get tvl => 'Total Value Locked';

  @override
  String get maxPriceStory => 'Maximum price per story';

  @override
  String get activeNodes => 'Active nodes';

  @override
  String get tmr => 'Total MasterNode Reward';

  @override
  String get nbr => 'Node Block Reward';

  @override
  String get nr24 => '24hr Reward';

  @override
  String get nr7 => '7 day Reward';

  @override
  String get nr30 => '30 day Reward';

  @override
  String get nosoPrice => 'Noso Price';

  @override
  String get launched => 'Running';

  @override
  String get available => 'Available';

  @override
  String get masternode => 'Masternode';

  @override
  String get empty => 'Empty';

  @override
  String get emptyNodesError => 'You don\'t have ready addresses to launch the masternode..';

  @override
  String get importKeysPair => 'Import from key pair';

  @override
  String get catHistoryTransaction => 'Transaction history';

  @override
  String get transactionInfo => 'Transaction information';

  @override
  String get block => 'Block';

  @override
  String get orderId => 'Order ID';

  @override
  String get receiver => 'Receiver';

  @override
  String get commission => 'Comission';

  @override
  String get openToExplorer => 'Open to Noso Explorer';

  @override
  String get shareTransaction => 'Share Transaction';

  @override
  String get message => 'Message';

  @override
  String get editCustom => 'Changing name';

  @override
  String get errorLoading => 'Server error';

  @override
  String get catActionAddress => 'Address actions';

  @override
  String get customNameAdd => 'Set Alias';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get sender => 'Sender';

  @override
  String get confirmDelete => 'Confirm remove address';

  @override
  String get aliasNameAddress => 'Change Alias';

  @override
  String get alias => 'Alias';

  @override
  String get consensusCheck => 'Consensus resolution';

  @override
  String get save => 'Save';

  @override
  String get nodeType => 'Node type';

  @override
  String get status => 'Status';

  @override
  String get balance => 'Balance';

  @override
  String get actionWallet => 'Actions on wallet';

  @override
  String get confirm => 'Confirm';

  @override
  String get createPayment => 'Create payment';

  @override
  String get amount => 'Amount';

  @override
  String get send => 'Send';

  @override
  String get chanceNode => 'Change node';

  @override
  String get viewQr => 'View Qr code';

  @override
  String get infoTotalPriceUst => 'Balance in USDT';

  @override
  String get updateInfo => 'Update information';

  @override
  String get copyAddress => 'Copy the address';

  @override
  String get informMyNodes => 'Status of your nodes';

  @override
  String get getKeysPair => 'View keys';

  @override
  String get reward => 'Reward';

  @override
  String get online => 'Online';

  @override
  String get sellAddress => 'Select an address';

  @override
  String get offline => 'Offline';

  @override
  String get emptyListAddress => 'Create or generate new addresses for your use';

  @override
  String get aliasMessage => 'The alias can be set from 3 to 32 characters long. Also, don\'t forget that a transaction fee is charged for setting up alias.';

  @override
  String get errorNoFoundCoinsTransaction => 'There are not enough coins for the transaction';

  @override
  String get errorInformationIncorrect => 'The shipping information is incorrect';

  @override
  String get errorImportAddresses => 'Addresses are not added because they are duplicates';

  @override
  String get errorDefaultErrorAlias => 'Error trying to set alias';

  @override
  String get priceInfoErrorServer => 'Price information is not available';

  @override
  String get errorEmptyHistoryTransactions => 'No transactions were found for this address';

  @override
  String get errorNoValidAddress => 'Error, invalid address';

  @override
  String get errorNoSync => 'The application is not synchronized with the main network';

  @override
  String get errorAddressBlock => 'Address blocked, payment cancelled';

  @override
  String get errorAddressFound => 'Recipient does not exist';

  @override
  String get sendProcess => 'Payment is awaiting confirmation';

  @override
  String get errorSendOrderDefault => 'Error sending payment, try again later';

  @override
  String get warringMessageSetAlias => 'The operation is available only once';

  @override
  String get successSetAlias => 'Your request is successful and has been processed';

  @override
  String get errorEmptyListWallet => 'This file does not contain an address';

  @override
  String get errorNotSupportedWallet => 'This file is not supported';

  @override
  String get errorLastTime => 'Your time is behind, please update your time';

  @override
  String get unknownError => 'An error occurred';
}
