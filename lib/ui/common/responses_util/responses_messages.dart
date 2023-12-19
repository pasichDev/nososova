import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class ResponsesErrors {
  static String getCodeToTextMessages(BuildContext context, int errorCode) {
    Map<int, String> messages = {
      0: AppLocalizations.of(context)!.unknownError,
      1: AppLocalizations.of(context)!.errorNoFoundCoinsTransaction,
      2: AppLocalizations.of(context)!.errorInformationIncorrect,
      3: AppLocalizations.of(context)!.errorDefaultErrorAlias,
      4: AppLocalizations.of(context)!.successSetAlias,
      5: AppLocalizations.of(context)!.errorEmptyListWallet,
      6: AppLocalizations.of(context)!.errorNotSupportedWallet,
      7: AppLocalizations.of(context)!.addressesAdded,
      8: AppLocalizations.of(context)!.errorImportAddresses,
    };
    if (messages.containsKey(errorCode)) {
      String? value = messages[errorCode];
      return value ?? AppLocalizations.of(context)!.unknownError;
    } else {
      return AppLocalizations.of(context)!.unknownError;
    }
  }
}