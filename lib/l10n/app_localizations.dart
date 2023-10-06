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

  /// No description provided for @overallOnBalance.
  ///
  /// In en, this message translates to:
  /// **'Overall on wallet'**
  String get overallOnBalance;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

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

  /// No description provided for @notImplemented.
  ///
  /// In en, this message translates to:
  /// **'The function is not implemented'**
  String get notImplemented;

  /// No description provided for @newTitle.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newTitle;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

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

  /// No description provided for @descriptionScannerCode.
  ///
  /// In en, this message translates to:
  /// **'Point the viewfinder at your QR Code'**
  String get descriptionScannerCode;

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
  /// **'Debug Information'**
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

  /// No description provided for @certificate.
  ///
  /// In en, this message translates to:
  /// **'Certificate'**
  String get certificate;

  /// No description provided for @sendFromAddress.
  ///
  /// In en, this message translates to:
  /// **'Send from this address'**
  String get sendFromAddress;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

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
