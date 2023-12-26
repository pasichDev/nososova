import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @incoming.
  ///
  /// In en, this message translates to:
  /// **'Incoming'**
  String get incoming;

  /// No description provided for @outgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get outgoing;

  /// No description provided for @wallets.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallets;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @node.
  ///
  /// In en, this message translates to:
  /// **'Node'**
  String get node;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get myAddresses;

  /// No description provided for @genNewKeyPair.
  ///
  /// In en, this message translates to:
  /// **'Generate new address'**
  String get genNewKeyPair;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// No description provided for @historyPayments.
  ///
  /// In en, this message translates to:
  /// **'Recent transactions'**
  String get historyPayments;

  /// No description provided for @titleScannerCode.
  ///
  /// In en, this message translates to:
  /// **'Qr Code scanner'**
  String get titleScannerCode;

  /// No description provided for @foundAddresses.
  ///
  /// In en, this message translates to:
  /// **'Found addresses'**
  String get foundAddresses;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @addToWallet.
  ///
  /// In en, this message translates to:
  /// **'Add to Wallet'**
  String get addToWallet;

  /// No description provided for @titleInfoNetwork.
  ///
  /// In en, this message translates to:
  /// **'Node info'**
  String get titleInfoNetwork;

  /// No description provided for @debugInfo.
  ///
  /// In en, this message translates to:
  /// **'Debugging'**
  String get debugInfo;

  /// No description provided for @connections.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections;

  /// No description provided for @lastBlock.
  ///
  /// In en, this message translates to:
  /// **'Last Block'**
  String get lastBlock;

  /// No description provided for @pendings.
  ///
  /// In en, this message translates to:
  /// **'Pendings'**
  String get pendings;

  /// No description provided for @branch.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get branch;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @utcTime.
  ///
  /// In en, this message translates to:
  /// **'UTC Time'**
  String get utcTime;

  /// No description provided for @pingMs.
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get pingMs;

  /// No description provided for @ping.
  ///
  /// In en, this message translates to:
  /// **'Ping'**
  String get ping;

  /// No description provided for @activeConnect.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get activeConnect;

  /// No description provided for @connection.
  ///
  /// In en, this message translates to:
  /// **'Searching for an available node..'**
  String get connection;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get errorConnection;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @keys.
  ///
  /// In en, this message translates to:
  /// **'Keys'**
  String get keys;

  /// No description provided for @sendFromAddress.
  ///
  /// In en, this message translates to:
  /// **'Send from this address'**
  String get sendFromAddress;

  /// No description provided for @removeAddress.
  ///
  /// In en, this message translates to:
  /// **'Remove address from wallet'**
  String get removeAddress;

  /// No description provided for @importFile.
  ///
  /// In en, this message translates to:
  /// **'Import from File'**
  String get importFile;

  /// No description provided for @importFileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a wallet file in .pkw or .nososova'**
  String get importFileSubtitle;

  /// No description provided for @exportFile.
  ///
  /// In en, this message translates to:
  /// **'Export to File'**
  String get exportFile;

  /// No description provided for @exportFileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save the wallet file in .pkw or .nososova'**
  String get exportFileSubtitle;

  /// No description provided for @fileWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet file'**
  String get fileWallet;

  /// No description provided for @newFormatWalletFileDescrypt.
  ///
  /// In en, this message translates to:
  /// **'Our exciting application offers you the opportunity to store your wallet in the most secure format'**
  String get newFormatWalletFileDescrypt;

  /// No description provided for @searchAddressResult.
  ///
  /// In en, this message translates to:
  /// **'Address found'**
  String get searchAddressResult;

  /// No description provided for @billAction.
  ///
  /// In en, this message translates to:
  /// **'Bill to this address'**
  String get billAction;

  /// No description provided for @addressesAdded.
  ///
  /// In en, this message translates to:
  /// **'Add new addresses to your wallet'**
  String get addressesAdded;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Synchronization'**
  String get sync;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @masternodes.
  ///
  /// In en, this message translates to:
  /// **'Masternodes'**
  String get masternodes;

  /// No description provided for @blocksRemaining.
  ///
  /// In en, this message translates to:
  /// **'Blocks Remaining'**
  String get blocksRemaining;

  /// No description provided for @daysUntilNextHalving.
  ///
  /// In en, this message translates to:
  /// **'Days until Next Halving'**
  String get daysUntilNextHalving;

  /// No description provided for @numberOfMinedCoins.
  ///
  /// In en, this message translates to:
  /// **'Number of mined coins'**
  String get numberOfMinedCoins;

  /// No description provided for @coinsLocked.
  ///
  /// In en, this message translates to:
  /// **'Coins Locked'**
  String get coinsLocked;

  /// No description provided for @marketcap.
  ///
  /// In en, this message translates to:
  /// **'Noso Marketcap'**
  String get marketcap;

  /// No description provided for @tvl.
  ///
  /// In en, this message translates to:
  /// **'Total Value Locked'**
  String get tvl;

  /// No description provided for @maxPriceStory.
  ///
  /// In en, this message translates to:
  /// **'Maximum price per story'**
  String get maxPriceStory;

  /// No description provided for @activeNodes.
  ///
  /// In en, this message translates to:
  /// **'Active nodes'**
  String get activeNodes;

  /// No description provided for @tmr.
  ///
  /// In en, this message translates to:
  /// **'Total MasterNode Reward'**
  String get tmr;

  /// No description provided for @nbr.
  ///
  /// In en, this message translates to:
  /// **'Node Block Reward'**
  String get nbr;

  /// No description provided for @nr24.
  ///
  /// In en, this message translates to:
  /// **'24hr Reward'**
  String get nr24;

  /// No description provided for @nr7.
  ///
  /// In en, this message translates to:
  /// **'7 day Reward'**
  String get nr7;

  /// No description provided for @nr30.
  ///
  /// In en, this message translates to:
  /// **'30 day Reward'**
  String get nr30;

  /// No description provided for @nosoPrice.
  ///
  /// In en, this message translates to:
  /// **'Noso Price'**
  String get nosoPrice;

  /// No description provided for @launched.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get launched;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @masternode.
  ///
  /// In en, this message translates to:
  /// **'Masternode'**
  String get masternode;

  /// No description provided for @empty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// No description provided for @emptyNodesError.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have ready addresses to launch the masternode..'**
  String get emptyNodesError;

  /// No description provided for @importKeysPair.
  ///
  /// In en, this message translates to:
  /// **'Import from key pair'**
  String get importKeysPair;

  /// No description provided for @catHistoryTransaction.
  ///
  /// In en, this message translates to:
  /// **'Transaction history'**
  String get catHistoryTransaction;

  /// No description provided for @transactionInfo.
  ///
  /// In en, this message translates to:
  /// **'Transaction information'**
  String get transactionInfo;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @receiver.
  ///
  /// In en, this message translates to:
  /// **'Receiver'**
  String get receiver;

  /// No description provided for @commission.
  ///
  /// In en, this message translates to:
  /// **'Comission'**
  String get commission;

  /// No description provided for @openToExplorer.
  ///
  /// In en, this message translates to:
  /// **'Open to Noso Explorer'**
  String get openToExplorer;

  /// No description provided for @shareTransaction.
  ///
  /// In en, this message translates to:
  /// **'Share Transaction'**
  String get shareTransaction;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @editCustom.
  ///
  /// In en, this message translates to:
  /// **'Changing name'**
  String get editCustom;

  /// No description provided for @errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get errorLoading;

  /// No description provided for @catActionAddress.
  ///
  /// In en, this message translates to:
  /// **'Address actions'**
  String get catActionAddress;

  /// No description provided for @customNameAdd.
  ///
  /// In en, this message translates to:
  /// **'Set Alias'**
  String get customNameAdd;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @sender.
  ///
  /// In en, this message translates to:
  /// **'Sender'**
  String get sender;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm remove address'**
  String get confirmDelete;

  /// No description provided for @aliasNameAddress.
  ///
  /// In en, this message translates to:
  /// **'Change Alias'**
  String get aliasNameAddress;

  /// No description provided for @alias.
  ///
  /// In en, this message translates to:
  /// **'Alias'**
  String get alias;

  /// No description provided for @consensusCheck.
  ///
  /// In en, this message translates to:
  /// **'Consensus resolution'**
  String get consensusCheck;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @nodeType.
  ///
  /// In en, this message translates to:
  /// **'Node type'**
  String get nodeType;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @actionWallet.
  ///
  /// In en, this message translates to:
  /// **'Actions on wallet'**
  String get actionWallet;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @createPayment.
  ///
  /// In en, this message translates to:
  /// **'Create payment'**
  String get createPayment;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @chanceNode.
  ///
  /// In en, this message translates to:
  /// **'Change node'**
  String get chanceNode;

  /// No description provided for @viewQr.
  ///
  /// In en, this message translates to:
  /// **'View Qr code'**
  String get viewQr;

  /// No description provided for @infoTotalPriceUst.
  ///
  /// In en, this message translates to:
  /// **'Balance in USDT'**
  String get infoTotalPriceUst;

  /// No description provided for @updateInfo.
  ///
  /// In en, this message translates to:
  /// **'Update information'**
  String get updateInfo;

  /// No description provided for @copyAddress.
  ///
  /// In en, this message translates to:
  /// **'Copy the address'**
  String get copyAddress;

  /// No description provided for @informMyNodes.
  ///
  /// In en, this message translates to:
  /// **'Status of your nodes'**
  String get informMyNodes;

  /// No description provided for @emptyListAddress.
  ///
  /// In en, this message translates to:
  /// **'Create or generate new addresses for your use'**
  String get emptyListAddress;

  /// No description provided for @aliasMessage.
  ///
  /// In en, this message translates to:
  /// **'The alias can be set from 3 to 32 characters long. Also, don\'t forget that a transaction fee is charged for setting up alias.'**
  String get aliasMessage;

  /// No description provided for @errorNoFoundCoinsTransaction.
  ///
  /// In en, this message translates to:
  /// **'There are not enough coins for the transaction'**
  String get errorNoFoundCoinsTransaction;

  /// No description provided for @errorInformationIncorrect.
  ///
  /// In en, this message translates to:
  /// **'The shipping information is incorrect'**
  String get errorInformationIncorrect;

  /// No description provided for @errorImportAddresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses are not added because they are duplicates'**
  String get errorImportAddresses;

  /// No description provided for @errorDefaultErrorAlias.
  ///
  /// In en, this message translates to:
  /// **'Error trying to set alias'**
  String get errorDefaultErrorAlias;

  /// No description provided for @priceInfoErrorServer.
  ///
  /// In en, this message translates to:
  /// **'Price information is not available'**
  String get priceInfoErrorServer;

  /// No description provided for @errorEmptyHistoryTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions were found for this address'**
  String get errorEmptyHistoryTransactions;

  /// No description provided for @errorNoValidAddress.
  ///
  /// In en, this message translates to:
  /// **'Error, invalid address'**
  String get errorNoValidAddress;

  /// No description provided for @errorNoSync.
  ///
  /// In en, this message translates to:
  /// **'The application is not synchronized with the main network'**
  String get errorNoSync;

  /// No description provided for @errorAddressBlock.
  ///
  /// In en, this message translates to:
  /// **'Address blocked, payment cancelled'**
  String get errorAddressBlock;

  /// No description provided for @errorAddressFound.
  ///
  /// In en, this message translates to:
  /// **'Recipient does not exist'**
  String get errorAddressFound;

  /// No description provided for @sendProcess.
  ///
  /// In en, this message translates to:
  /// **'Payment is awaiting confirmation'**
  String get sendProcess;

  /// No description provided for @errorSendOrderDefault.
  ///
  /// In en, this message translates to:
  /// **'Error sending payment, try again later'**
  String get errorSendOrderDefault;

  /// No description provided for @warringMessageSetAlias.
  ///
  /// In en, this message translates to:
  /// **'The operation is available only once'**
  String get warringMessageSetAlias;

  /// No description provided for @successSetAlias.
  ///
  /// In en, this message translates to:
  /// **'Your request is successful and has been processed'**
  String get successSetAlias;

  /// No description provided for @errorEmptyListWallet.
  ///
  /// In en, this message translates to:
  /// **'This file does not contain an address'**
  String get errorEmptyListWallet;

  /// No description provided for @errorNotSupportedWallet.
  ///
  /// In en, this message translates to:
  /// **'This file is not supported'**
  String get errorNotSupportedWallet;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get unknownError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
