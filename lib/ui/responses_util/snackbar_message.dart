import 'package:flutter/material.dart';
import 'package:nososova/models/app/response_page_listener.dart';
import 'package:nososova/ui/responses_util/responses_messages.dart';

import '../theme/style/colors.dart';
import '../theme/style/text_style.dart';

class SnackBarWidgetResponse {
  final BuildContext context;
  final ResponseListenerPage response;

  SnackBarWidgetResponse({
    required this.context,
    required this.response,
  });

  get() {
    Color snackBarBackgroundColor = response.snackBarType == SnackBarType.error
        ? CustomColors.negativeBalance
        : CustomColors.positiveBalance;
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        ResponsesErrors.getCodeToTextMessages(context, response.codeMessage),
        style: AppTextStyles.walletAddress.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: snackBarBackgroundColor,
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
    ));
  }
}