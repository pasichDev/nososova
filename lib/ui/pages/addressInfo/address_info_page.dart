import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/pages/addressInfo/screens/address_actions.dart';
import 'package:nososova/ui/pages/addressInfo/screens/history_transaction.dart';
import 'package:nososova/ui/pages/addressInfo/screens/pendings_widget.dart';
import 'package:nososova/utils/noso/src/address_object.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../blocs/wallet_bloc.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/const/const.dart';
import '../../components/network_info.dart';
import '../../theme/anim/transform_widget.dart';
import '../../theme/decoration/card_gradient_decoration.dart';
import '../../theme/decoration/other_gradient_decoration.dart';
import '../../theme/style/text_style.dart';

class AddressInfoPage extends StatefulWidget {
  final String hash;

  const AddressInfoPage({Key? key, required this.hash}) : super(key: key);

  @override
  AddressInfoPageState createState() => AddressInfoPageState();
}

class AddressInfoPageState extends State<AddressInfoPage> {
  var isReverse = false;
  var isMiddleChange = false;
  int selectedIndexChild = 0;
  int selectedOption = 1;
  late HistoryTransactionsWidget historyWidget;
  late Address address;

  @override
  void initState() {
    super.initState();
    address = BlocProvider.of<WalletBloc>(context)
            .state
            .wallet
            .getAddress(widget.hash) ??
        Address(hash: "", publicKey: "", privateKey: "");
    historyWidget = HistoryTransactionsWidget(address: address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: NetworkInfo(
            nodeStatusDialog: () => {}),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
        return Container(
          decoration: const OtherGradientDecoration(),
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TransformWidget(
                  widget: _cardAddress(address),
                  changer: (reverse) {},
                  middleChanger: (middle) {
                    if (mounted) {
                      setState(() {
                        selectedIndexChild = selectedIndexChild == 0 ? 1 : 0;
                      });
                    }
                  },
                ),
              ),
              PendingsWidget(address: address),
              Expanded(
                  child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: selectedIndexChild == 0
                    ? historyWidget
                    : AddressActionsWidget(address: address),
              )),
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
            // color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: selectedOption == 1
                            ? const Color(0xFF53566E).withOpacity(0.7)
                            : Colors.white.withOpacity(0.05),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedOption = 1;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          AppLocalizations.of(context)!.address,
                          style: AppTextStyles.categoryStyle
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: selectedOption == 2
                            ? const Color(0xFF53566E).withOpacity(0.7)
                            : Colors.white.withOpacity(0.1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedOption = 2;
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            AppLocalizations.of(context)!.keys,
                            style: AppTextStyles.categoryStyle
                                .copyWith(fontSize: 16, color: Colors.white),
                          )),
                    )
                  ],
                )),
                QrImageView(
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
                  size: 200.0,
                ),
              ],
            ),
          ),
        ));
  }

  _cardAddress(Address mAddress) {
    return Container(
        height: 230,
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
            Const.coinName,
            style: AppTextStyles.titleMax
                .copyWith(color: Colors.white.withOpacity(0.4)),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                targetAddress.balance.toString(),
                style: AppTextStyles.titleMax.copyWith(
                  fontSize: 36,
                  color: Colors.white.withOpacity(1),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                targetAddress.nameAddressFull,
                style: AppTextStyles.titleMax.copyWith(
                  fontSize: 24,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
