import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noso_dart/const.dart';
import 'package:noso_dart/utils.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../blocs/events/wallet_events.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../common/responses_util/response_widget_id.dart';
import '../../config/responsive.dart';
import '../../theme/decoration/textfield_decoration.dart';
import '../../theme/style/text_style.dart';

class DialogCustomName extends StatefulWidget {
  final Address address;

  const DialogCustomName({super.key, required this.address});

  @override
  State createState() => _DialogCustomNameState();
}

class _DialogCustomNameState extends State<DialogCustomName> {
  bool isWaiting = true;
  bool isActiveButtonSend = false;

  late TextEditingController customNameController;
  late WalletBloc walletBloc;
  int widgetId = ResponseWidgetsIds.widgetSetAliasName;

  late StreamSubscription listenResponse;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    customNameController =
        TextEditingController(text: widget.address.custom ?? "");
    listenResponse = walletBloc.getResponseStatusStream.listen((response) {
      if (response.idWidget == widgetId || mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    listenResponse.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext cx) {
    return LayoutBuilder(builder: (cx, _) {
      return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(cx).viewInsets.bottom),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isMobile(context)) ...[
                  Text(
                    AppLocalizations.of(context)!.customNameAdd,
                    style: AppTextStyles.dialogTitle,
                  ),
                  const SizedBox(height: 20)
                ],
                Text(
                  AppLocalizations.of(context)!.aliasMessage,
                  style: AppTextStyles.itemStyle.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.warringMessageSetAlias,
                  style: AppTextStyles.walletAddress.copyWith(
                      fontSize: 18, color: CustomColors.negativeBalance),
                ),
                const SizedBox(height: 20),
                TextField(
                    enabled: isWaiting,
                    autofocus: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@*+\-_:]')),
                    ],
                    controller: customNameController,
                    style: AppTextStyles.textFieldStyle,
                    onChanged: (text) => _checkAliasText(text),
                    decoration: AppTextFiledDecoration.defaultDecoration(
                        AppLocalizations.of(context)!.alias)),
                const SizedBox(height: 20),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.commission,
                        style: AppTextStyles.walletAddress.copyWith(
                            color: Colors.black.withOpacity(1), fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        (NosoConst.customizationFee / 100000000).toStringAsFixed(8),
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                    ]),
                const SizedBox(height: 20),
                Center(
                  child: SwipeableButtonView(
                    isActive: isActiveButtonSend,
                    buttonText: AppLocalizations.of(context)!.save,
                    buttonWidget: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                    activeColor: const Color(0xFF2B2F4F),
                    //   isFinished: isFinished,

                    onWaitingProcess: () {
                      isWaiting = false;
                      walletBloc.add(SetAlias(
                          customNameController.text, widget.address, widgetId));
                    },
                    onFinish: () async {
                      isWaiting = false;
                    },
                  ),
                ),
              ],
            ),
          ));
    });
  }

  _checkAliasText(String text) {
    setState(() {
      if (text == widget.address.custom || !OtherUtils.isValidHashNoso(text)) {
        isActiveButtonSend = false;
      } else {
        isActiveButtonSend = true;
      }
    });
  }
}
