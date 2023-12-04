import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/pages/payment/payment_page.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';

import '../../../../../blocs/events/wallet_events.dart';
import '../../../../../blocs/wallet_bloc.dart';
import '../../../../../generated/assets.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../utils/noso/src/address_object.dart';
import '../../../dialogs/dialog_view_qr.dart';

class AddressInfo extends StatefulWidget {
  final Address address;

  const AddressInfo({Key? key, required this.address}) : super(key: key);

  @override
  AddressInfoState createState() => AddressInfoState();
}

class AddressInfoState extends State<AddressInfo> {
  late WalletBloc walletBloc;
  int selectedOption = 1;

  AddressInfoState({
    Key? key,
  });

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.address.hash));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.copy,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.address.hash,
                  style: AppTextStyles.walletAddress.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () => _viewQr(context),
              icon: SvgPicture.asset(
                Assets.iconsScan,
                height: 28,
                width: 28,
              ))
        ],
      ),
      const SizedBox(height: 10),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //   buildListTile(Icons.confirmation_num_outlined,
          //     AppLocalizations.of(context)!.certificate, () {}),
          // buildListTile(Icons.account_balance_wallet_outlined,
          //   AppLocalizations.of(context)!.billAction, () {}),
          buildListTileSvg(
              Assets.iconsOutput,
              AppLocalizations.of(context)!.sendFromAddress,
              () => _paymentPage(context)),
          // buildListTile(
          //    Icons.lock_outline, AppLocalizations.of(context)!.lock, () {}),
          buildListTileSvg(
              Assets.iconsDelete, AppLocalizations.of(context)!.removeAddress, () {
            walletBloc.add(DeleteAddress(widget.address));
            Navigator.pop(context);
          })
        ],
      ),
    ]);
  }

  void _viewQr(BuildContext context) {
    Navigator.pop(context);
    DialogViewQr().loadDialog(context: context, address: widget.address);
  }

  void _paymentPage(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(address: widget.address),
      ),
    );
  }
}
