import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/pages/addressInfo/screens/card_address.dart';
import 'package:nososova/ui/pages/addressInfo/screens/history_transaction.dart';
import 'package:nososova/ui/pages/addressInfo/screens/pendings_widget.dart';

import '../../../blocs/wallet_bloc.dart';
import '../../theme/decoration/other_gradient_decoration.dart';

class AddressInfoPage extends StatelessWidget {
  final String hash;

  AddressInfoPage({Key? key, required this.hash}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
        var address = state.wallet.getAddress(hash);
        if (address == null) {
          return Container();
        }
        return Container(
          decoration: const OtherGradientDecoration(),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    PendingsWidget(address: address),
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        child: HistoryTransactionsWidget(address: address))
                  ],
                ),
              ),
              Positioned(
                  top: 130,
                  left: 20,
                  right: 20,
                  child: CardAddress(
                    address: address,
                  ))
            ],
          ),
        );
      }),
    );
  }
}
