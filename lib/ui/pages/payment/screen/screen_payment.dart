import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noso_dart/utils.dart';
import 'package:nososova/models/apiExplorer/transaction_history.dart';
import 'package:nososova/ui/common/route/dialog_router.dart';
import 'package:nososova/ui/theme/decoration/textfield_decoration.dart';
import 'package:nososova/ui/tiles/tile_wallet_address.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../../../blocs/events/wallet_events.dart';
import '../../../../blocs/wallet_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../models/address_wallet.dart';
import '../../../../models/app/response_page_listener.dart';
import '../../../common/responses_util/response_widget_id.dart';
import '../../../common/responses_util/snackbar_message.dart';
import '../../../common/widgets/widget_transaction.dart';
import '../../../theme/style/colors.dart';
import '../../../theme/style/text_style.dart';
import '../../../tiles/tile_select_address.dart';

class PaymentScreen extends StatefulWidget {
  final Address address;
  final String receiver;

  const PaymentScreen({Key? key, required this.address, this.receiver = ""})
      : super(key: key);

  @override
  State createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Address targetAddress;
  late StreamSubscription listenResponse;
  bool isFinished = false;
  bool isActiveButtonSend = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController receiverController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  double selButton = 0;
  double commission = 0;
  Key containerKey = UniqueKey();
  bool isResultWidget = false;
  late TransactionHistory transactionHistory;

  @override
  void initState() {
    receiverController.text = widget.receiver.isEmpty ? "" : widget.receiver;
    super.initState();
    targetAddress = widget.address;

    var bloc = BlocProvider.of<WalletBloc>(context);
    bloc.stream.listen((state) {
      Address desireAddress = state.wallet.address.firstWhere(
        (element) => element.hash == widget.address.hash,
        orElse: () => Address(hash: "", publicKey: "", privateKey: ""),
      );

      if (desireAddress.hash.isNotEmpty) {
        targetAddress = desireAddress;
      } else {
        if (mounted) {
          Navigator.pop(context);
          SnackBarWidgetResponse(
                  context: GlobalKey<ScaffoldMessengerState>().currentContext ??
                      context,
                  response: ResponseListenerPage(
                      codeMessage: 9, snackBarType: SnackBarType.error))
              .get();
        }
      }
    });

    _responseListener(bloc);
  }

  void _responseListener(WalletBloc bloc) {
    listenResponse = bloc.getResponseStatusStream.listen((response) async {
      if (mounted && ResponseWidgetsIds.pageSendOrder == response.idWidget) {
        if (response.codeMessage == 4 &&
            response.snackBarType == SnackBarType.ignore) {
          await Future.delayed(const Duration(milliseconds: 500));
          transactionHistory = response.actionValue;
          setState(() {
            isResultWidget = true;
          });
        }

        if (response.snackBarType != SnackBarType.ignore) {
          await Future.delayed(const Duration(milliseconds: 200));
          SnackBarWidgetResponse(
                  context: GlobalKey<ScaffoldMessengerState>().currentContext ??
                      context,
                  response: response)
              .get();
          setState(() {
            containerKey = UniqueKey();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    listenResponse.cancel();
    super.dispose();
  }

  void refreshAddress(Address address) {
    setState(() {
      targetAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: !isResultWidget
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          AppLocalizations.of(context)!.sender,
                          textAlign: TextAlign.start,
                          style:
                              AppTextStyles.dialogTitle.copyWith(fontSize: 22),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: targetAddress.hash.isEmpty
                                ? SelectAddressListTile(
                                    onTap: () =>
                                        DialogRouter.showDialogSellAddress(
                                            context,
                                            targetAddress,
                                            (selAddress) =>
                                                refreshAddress(selAddress)))
                                : AddressListTile(
                                    address: targetAddress,
                                    onLong: () {},
                                    onTap: () =>
                                        DialogRouter.showDialogSellAddress(
                                            context,
                                            targetAddress,
                                            (selAddress) =>
                                                refreshAddress(selAddress)),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.receiver,
                          textAlign: TextAlign.start,
                          style:
                              AppTextStyles.dialogTitle.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                            maxLength: 33,
                            onChanged: (text) => checkButtonActive(null),
                            controller: receiverController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9@*+\-_:]')),
                            ],
                            style: AppTextStyles.textFieldStyle,
                            decoration:
                                AppTextFiledDecoration.defaultDecoration(
                                    AppLocalizations.of(context)!.receiver)),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.amount,
                          textAlign: TextAlign.start,
                          style:
                              AppTextStyles.dialogTitle.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                            onChanged: (text) => checkButtonActive(null),
                            controller: amountController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*')),
                              TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                var value = double.parse(newValue.text.isEmpty
                                    ? "0"
                                    : newValue.text);
                                if (value <= targetAddress.availableBalance) {
                                  return newValue;
                                }

                                return oldValue;
                              })
                            ],
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: AppTextStyles.textFieldStyle,
                            decoration:
                                AppTextFiledDecoration.defaultDecoration(
                                    "0.0000000")),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buttonPercent(25),
                            buttonPercent(50),
                            buttonPercent(75),
                            buttonPercent(100),
                          ],
                        ),
                        /*       const SizedBox(height: 30),
                          TextField(
                              maxLength: 120,
                              controller: messageController,
                              style: AppTextStyles.textFieldStyle,
                              decoration:
                                  AppTextFiledDecoration.defaultDecoration(
                                      AppLocalizations.of(context)!.message)),

                    */
                        const SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.commission,
                                style: AppTextStyles.walletAddress.copyWith(
                                    color: Colors.black.withOpacity(1),
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                (commission).toStringAsFixed(8),
                                style: AppTextStyles.walletAddress.copyWith(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ]),
                        const SizedBox(height: 30),
                        Center(
                            key: containerKey,
                            child: SwipeableButtonView(
                              isActive: isActiveButtonSend,
                              buttonText: AppLocalizations.of(context)!.send,
                              buttonWidget: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.grey,
                              ),
                              activeColor: const Color(0xFF2B2F4F),
                              onWaitingProcess: () => sendOrder(),
                              onFinish: () {},
                            )),
                        const SizedBox(height: 30),
                      ]),
                ),
              )
            : TransactionWidgetInfo(
                transaction: transactionHistory,
                isReceiver: false,
                isProcess: true,
              ));
  }

  int doubleToIndianInt(double value) {
    return (value * 100000000).round();
  }

  sendOrder() {
    BlocProvider.of<WalletBloc>(context).add(SendOrder(
        receiverController.text,
        messageController.text,
        double.parse(amountController.text),
        widget.address,
        ResponseWidgetsIds.pageSendOrder));
  }

  double getFee(double amount) {
    double result = (amount / 0.00010000) / 100000000;
    if (result < 0.01000000) {
      return 0.01000000;
    }
    return result;
  }

  checkButtonActive(double? amountVal) {
    double amount = amountVal ??
        double.parse(
            amountController.text.isEmpty ? "0" : amountController.text);
    var receiver =
        receiverController.text.isEmpty ? "" : receiverController.text;

    commission = getFee(amount);
    var priceCheck = amountController.text.isEmpty
        ? false
        : targetAddress.availableBalance >= amount + commission;
    var receiverCheck = targetAddress.hash == receiverController.text
        ? false
        : OtherUtils.isValidHashNoso(receiver);

    setState(() {
      if (selButton !=
          double.parse(
              amountController.text.isEmpty ? "0" : amountController.text)) {
        selButton = -1;
      }
      isActiveButtonSend = priceCheck && receiverCheck;
    });
  }

  buttonPercent(int percent) {
    double value = double.parse(
        ((percent / 100) * targetAddress.availableBalance).toStringAsFixed(7));
    var valueAmount = (value - getFee(value));

    return OutlinedButton(
        onPressed: () {
          if (targetAddress.hash.isNotEmpty) {
            setState(() {
              amountController.text = valueAmount.toStringAsFixed(7);
              selButton = double.parse(valueAmount.toStringAsFixed(7));

              checkButtonActive(valueAmount);
            });
          }
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              selButton == double.parse(valueAmount.toStringAsFixed(7))
                  ? CustomColors.primaryColor.withOpacity(0.3)
                  : Colors.transparent,
          side: BorderSide(
              color: selButton == double.parse(valueAmount.toStringAsFixed(7))
                  ? CustomColors.primaryColor.withOpacity(0.5)
                  : Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text("$percent%",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: selButton ==
                            double.parse(valueAmount.toStringAsFixed(7))
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selButton ==
                            double.parse(valueAmount.toStringAsFixed(7))
                        ? CustomColors.primaryColor.withOpacity(0.9)
                        : Colors.black))));
  }
}
