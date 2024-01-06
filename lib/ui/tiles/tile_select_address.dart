import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../generated/assets.dart';
import '../../l10n/app_localizations.dart';
import '../theme/style/icons_style.dart';

class SelectAddressListTile extends StatefulWidget {
  final VoidCallback onTap;

  const SelectAddressListTile({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State createState() => SelectAddressListTileState();
}

class SelectAddressListTileState extends State<SelectAddressListTile> {
  Widget _iconAddress() {
    return AppIconsStyle.icon3x2(Assets.iconsCard);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.only(left: 10, right: 15),
        leading: _iconAddress(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.sellAddress,
                  style: AppTextStyles.walletAddress.copyWith(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
        onTap: widget.onTap);
  }
}
