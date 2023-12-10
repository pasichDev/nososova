import 'package:flutter/material.dart';
import 'package:nososova/utils/noso/src/address_object.dart';

import '../../../../generated/assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../theme/style/text_style.dart';
import '../../../tiles/dialog_tile.dart';

class AddressActionsWidget extends StatelessWidget {
  final Address address;

  const AddressActionsWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
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
          buildListTileSvg(Assets.iconsRename,
              AppLocalizations.of(context)!.customNameAdd, () {}),
          buildListTileSvg(Assets.iconsDelete,
              AppLocalizations.of(context)!.removeAddress, () {}),
        ]));
  }
}
