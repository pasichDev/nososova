import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noso_dart/const.dart';
import 'package:nososova/ui/pages/addressInfo/screens/address_actions.dart';
import 'package:nososova/ui/pages/addressInfo/screens/history_transaction.dart';
import 'package:nososova/ui/pages/addressInfo/screens/pendings_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../blocs/events/history_transactions_events.dart';
import '../../../blocs/history_transactions_bloc.dart';
import '../../../blocs/wallet_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../common/components/app_bar_other_page.dart';
import '../../common/responses_util/response_widget_id.dart';
import '../../common/responses_util/snackbar_message.dart';
import '../../common/widgets/node_light_status.dart';
import '../../config/responsive.dart';
import '../../theme/anim/transform_widget.dart';
import '../../theme/decoration/card_gradient_decoration.dart';
import '../../theme/decoration/other_gradient_decoration.dart';
import '../../theme/style/text_style.dart';
import '../main/widgets/default_app_bar.dart';

class AddressInfoPage extends StatefulWidget {
  final String hash;

  const AddressInfoPage({Key? key, required this.hash}) : super(key: key);

  @override
  State createState() => _AddressInfoPageState();
}

class _AddressInfoPageState extends State<AddressInfoPage> {
  var isReverse = false;
  var isMiddleChange = false;
  int selectedIndexChild = 0;
  int selectedOption = 1;
  late Address address;
  late WalletBloc walletBloc;
  late StreamSubscription listenResponse;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    address = walletBloc.state.wallet.getAddress(widget.hash) ??
        Address(hash: "", publicKey: "", privateKey: "");
    BlocProvider.of<HistoryTransactionsBloc>(context)
        .add(FetchHistory(address.hash));
    _responseListener();
  }

  void _responseListener() {
    listenResponse =
        walletBloc.getResponseStatusStream.listen((response) async {
      if (mounted &&
          ResponseWidgetsIds.idsPageAddressInfo.contains(response.idWidget)) {
        await Future.delayed(const Duration(milliseconds: 200));
        SnackBarWidgetResponse(
                context: GlobalKey<ScaffoldMessengerState>().currentContext ??
                    context,
                response: response)
            .get();
      }
    });
  }

  @override
  void dispose() {
    listenResponse.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(onNodeStatusDialog: () {}),
      body: BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
        return Container(
          decoration: Responsive.isMobile(context)
              ? const OtherGradientDecoration()
              : const BoxDecoration(),
          child: SafeArea(
              child: Row(
            children: [
              if (!Responsive.isMobile(context))
                Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: !Responsive.isMobile(context)
                          ? BorderRadius.zero
                          : const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                      child: !Responsive.isMobile(context)
                          ? HistoryTransactionsWidget(address: address)
                          : selectedIndexChild == 0
                              ? HistoryTransactionsWidget(address: address)
                              : AddressActionsWidget(address: address),
                    )),
              Expanded(
                  flex: 3,
                  child: Container(
                      decoration: !Responsive.isMobile(context)
                          ? const OtherGradientDecoration()
                          : const BoxDecoration(),
                      child: Column(
                        children: [
                          if (!Responsive.isMobile(context))
                            const DefaultAppBar(isVisible: true),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TransformWidget(
                              widget: _cardAddress(address),
                              changer: (reverse) {},
                              middleChanger: (middle) {
                                if (mounted) {
                                  setState(() {
                                    selectedIndexChild =
                                        selectedIndexChild == 0 ? 1 : 0;
                                  });
                                }
                              },
                            ),
                          ),
                          if (address.nodeAvailable)
                            NodeLightStatus(address: address)
                          else
                            PendingsWidget(address: address),
                          Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: !Responsive.isMobile(context)
                                    ? BorderRadius.zero
                                    : const BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                child: !Responsive.isMobile(context)
                                    ? AddressActionsWidget(address: address)
                                    : selectedIndexChild == 0
                                        ? HistoryTransactionsWidget(
                                            address: address)
                                        : AddressActionsWidget(
                                            address: address),
                              )),
                        ],
                      ))),
            ],
          )),
        );
      }),
    );
  }

  _qrCodeAddress(Address address) {
    return Transform.scale(
        scaleX: -1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                                backgroundColor: selectedOption == 1
                                    ? const Color(0xFF53566E).withOpacity(0.7)
                                    : Colors.white.withOpacity(0.05),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedOption = 1;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  AppLocalizations.of(context)!.address,
                                  style: AppTextStyles.categoryStyle.copyWith(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                                backgroundColor: selectedOption == 2
                                    ? const Color(0xFF53566E).withOpacity(0.7)
                                    : Colors.white.withOpacity(0.1),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedOption = 2;
                                });
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    AppLocalizations.of(context)!.keys,
                                    style: AppTextStyles.categoryStyle.copyWith(
                                        fontSize: 16, color: Colors.white),
                                  )),
                            ))
                      ],
                    )),
                if (Responsive.isMobile(context)) const SizedBox(width: 70),
                Expanded(
                    flex: 2,
                    child: QrImageView(
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      data: selectedOption == 1
                          ? address.hash
                          : "${address.publicKey} ${address.privateKey}",
                      version: QrVersions.auto,
                      size: 160.0,
                    )),
              ],
            ),
          ),
        ));
  }

  _cardAddress(Address mAddress) {
    return Container(
        height: 230,
        width: double.infinity,
        decoration: const CardDecoration(),
        child: IndexedStack(
            index: selectedIndexChild,
            children: [_cardInfo(mAddress), _qrCodeAddress(address)]));
  }

  _cardInfo(Address targetAddress) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          child: Text(
            NosoConst.coinName,
            style: AppTextStyles.titleMax.copyWith(
              color: Colors.white.withOpacity(0.4),
              fontSize: 32,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                  message: AppLocalizations.of(context)!.balance,
                  child: Text(
                    targetAddress.balance.toStringAsFixed(8),
                    style: AppTextStyles.titleMax.copyWith(
                      fontSize: 32,
                      color: Colors.white.withOpacity(1),
                    ),
                  )),
              const SizedBox(height: 15),
              Tooltip(
                  message: AppLocalizations.of(context)!.copyAddress,
                  child: InkWell(
                    onTap: () => Clipboard.setData(
                        ClipboardData(text: targetAddress.hash)),
                    child: Text(
                      targetAddress.hashPublic,
                      style: AppTextStyles.titleMax.copyWith(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
