import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/route/dialog_router.dart';
import 'package:nososova/ui/route/page_router.dart';
import 'package:nososova/ui/theme/style/text_style.dart';
import 'package:nososova/ui/tiles/dialog_tile.dart';

import '../../../../blocs/events/wallet_events.dart';
import '../../../../blocs/wallet_bloc.dart';
import '../../../../generated/assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../utils/noso/model/address_object.dart';
import '../../tiles/tile_сonfirm_list.dart';

class AddressInfo extends StatefulWidget {
  final Address address;

  const AddressInfo({Key? key, required this.address}) : super(key: key);

  @override
  AddressInfoState createState() => AddressInfoState();
}

class AddressInfoState extends State<AddressInfo> {
  late WalletBloc walletBloc;

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
                  widget.address.nameAddressFull,
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
          buildListTileSvg(
              Assets.iconsOutput,
              AppLocalizations.of(context)!.sendFromAddress,
              () => _paymentPage(context)),
          TileConfirmList(
              iconData: Assets.iconsDelete,
              title: AppLocalizations.of(context)!.removeAddress,
              confirm: AppLocalizations.of(context)!.confirmDelete,
              onClick: () {
                walletBloc.add(DeleteAddress(widget.address));
                Navigator.pop(context);
              })
        ],
      ),
    ]);
  }

  void _viewQr(BuildContext context) {
    Navigator.pop(context);
    DialogRouter.showDialogViewQr(context, widget.address);
  }

  void _paymentPage(BuildContext context) {
    Navigator.pop(context);
    PageRouter.routePaymentPage(context, widget.address);
  }
}
