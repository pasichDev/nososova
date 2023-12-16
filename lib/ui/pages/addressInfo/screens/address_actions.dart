import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/dialogs/dialog_custom_name.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

import '../../../../blocs/events/wallet_events.dart';
import '../../../../blocs/wallet_bloc.dart';
import '../../../../generated/assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../theme/style/dialog_style.dart';
import '../../../theme/style/text_style.dart';
import '../../../tiles/dialog_tile.dart';
import '../../../tiles/tile_сonfirm_list.dart';

class AddressActionsWidget extends StatelessWidget {
  final Address address;

  const AddressActionsWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    var walletBloc = BlocProvider.of<WalletBloc>(context);
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.infinity,
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: Text(AppLocalizations.of(context)!.catActionAddress,
                  style: AppTextStyles.categoryStyle)),
          buildListTileSvg(Assets.iconsOutput,
              AppLocalizations.of(context)!.sendFromAddress, () => {}),
          if (address.custom == null)
            buildListTileSvg(
                Assets.iconsRename,
                enabled: address.custom == null,
                AppLocalizations.of(context)!.customNameAdd,
                () => _showDialogCustomName(context)),
          TileConfirmList(
              iconData: Assets.iconsDelete,
              title: AppLocalizations.of(context)!.removeAddress,
              confirm: AppLocalizations.of(context)!.confirmDelete,
              onClick: () {
                walletBloc.add(DeleteAddress(address));
                Navigator.pop(context);
              }),
        ]));
  }

  void _showDialogCustomName(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: DialogStyle.borderShape,
        context: context,
        builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<WalletBloc>(context),
                ),
              ],
              child: DialogCustomName(address: address),
            ));
  }
}
