import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/events/wallet_events.dart';
import '../../../blocs/wallet_bloc.dart';
import '../../../generated/assets.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/address_wallet.dart';
import '../../common/route/dialog_router.dart';
import '../../common/route/page_router.dart';
import '../../config/responsive.dart';
import '../../theme/style/text_style.dart';
import '../../tiles/dialog_tile.dart';
import '../../tiles/tile_сonfirm_list.dart';

class AddressInfo extends StatefulWidget {
  final Address address;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AddressInfo(
      {Key? key, required this.address, required this.scaffoldKey})
      : super(key: key);

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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Responsive.isMobile(context)) ...[
            Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Text(
                  widget.address.nameAddressPublic,
                  style: AppTextStyles.dialogTitle,
                ))
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildListTileSvg(
                  Assets.iconsOutput,
                  AppLocalizations.of(context)!.sendFromAddress,
                  () => _paymentPage(context)),
              buildListTileSvg(Assets.iconsScan,
                  AppLocalizations.of(context)!.viewQr, () => _viewQr(context)),
              buildListTileSvg(
                  Assets.iconsTextTwo,
                  AppLocalizations.of(context)!.copyAddress,
                  () => _copy(context)),
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

  void _copy(BuildContext context) {
    Navigator.pop(context);
    Clipboard.setData(ClipboardData(text: widget.address.hash));
  }

  void _viewQr(BuildContext context) {
    Navigator.pop(context);
    DialogRouter.showDialogViewQr(context, widget.address);
  }

  void _paymentPage(BuildContext context) {
    Navigator.pop(context);
    PageRouter.routePaymentPage(
        widget.scaffoldKey.currentContext ?? context, widget.address);
  }
}
