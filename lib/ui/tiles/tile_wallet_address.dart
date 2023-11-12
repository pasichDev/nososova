import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../generated/assets.dart';
import '../../utils/noso/src/address_object.dart';

class AddressListTile extends StatelessWidget {
  final VoidCallback onButtonClick;
  final Address address;
  final TextStyle _smallTextSize = const TextStyle(fontSize: 16.0);

  const AddressListTile(
      {super.key, required this.address, required this.onButtonClick});


  hashObfuscation(String hash){
    if (hash.length >= 25) {
    return "${hash.substring(0, 9)}...${hash.substring(hash.length - 9)}";
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  SvgPicture.asset(
        Assets.iconsCard,
        width: 28,
        height: 28,
        color: Colors.grey,
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(hashObfuscation(address.hash.toString()), style: AppTextStyles.walletAddress),
          const SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "${AppLocalizations.of(context)!.incoming}: 0",
              style: AppTextStyles.itemStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(width: 5),
            Text(
              "${AppLocalizations.of(context)!.outgoing}: 0",
                style: AppTextStyles.itemStyle.copyWith(fontSize: 16)
            )
          ])
        ]),
      Text(
             address.balance.toStringAsFixed(3),
              style:AppTextStyles.walletAddress,
           ),
      ]),
      onTap: onButtonClick,
    );
  }
}
//