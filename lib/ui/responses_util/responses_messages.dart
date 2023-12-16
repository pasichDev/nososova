import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class ResponsesErrors {
  static String getCodeToTextMessages(BuildContext context, int errorCode) {
    Map<int, String> messages = {
      0: "Unidentified error",
      1: AppLocalizations.of(context)!.errorNoFoundCoinsTransaction,
      2: AppLocalizations.of(context)!.errorInformationIncorrect,
      3: AppLocalizations.of(context)!.errorDefaultErrorAlias,
      4: AppLocalizations.of(context)!.successSetAlias,
    };
    if (messages.containsKey(errorCode)) {
      String? value = messages[errorCode];
      return value ?? "Unidentified error";
    } else {
      return "Unidentified error";
    }
  }
}
