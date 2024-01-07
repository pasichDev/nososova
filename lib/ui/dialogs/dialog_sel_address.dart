import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../l10n/app_localizations.dart';
import '../../models/address_wallet.dart';
import '../theme/style/text_style.dart';
import '../tiles/tile_wallet_address.dart';

class DialogSellAddress extends StatefulWidget {
  final Address targetAddress;
  final Function(Address) selected;

  const DialogSellAddress(
      {super.key, required this.targetAddress, required this.selected});

  @override
  State createState() => DialogSellAddressState();
}

class DialogSellAddressState extends State<DialogSellAddress> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
      var listAddress = state.wallet.address;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Text(
                AppLocalizations.of(context)!.sellAddress,
                style: AppTextStyles.dialogTitle,
              )),
          const SizedBox(height: 0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              shrinkWrap: true,
              controller: _controller,
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              itemCount: listAddress.length,
              itemBuilder: (context, index) {
                final item = listAddress[index];
                return Container(
                    color: widget.targetAddress.hash == item.hash
                        ? CustomColors.positiveBalance.withOpacity(0.3)
                        : Colors.transparent,
                    child: AddressListTile(
                      address: item,
                      onLong: () {},
                      onTap: () {
                        Navigator.pop(context);
                        widget.selected(item);
                      },
                    ));
              },
            ),
          )
        ],
      );
    });
  }
}
