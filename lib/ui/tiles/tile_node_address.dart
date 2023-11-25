import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../generated/assets.dart';
import '../../utils/noso/src/address_object.dart';
import '../theme/anim/blinkin.dart';

class AddressNodeTile extends StatefulWidget {
  final Address address;

  const AddressNodeTile({Key? key, required this.address}) : super(key: key);

  @override
  AddressListTileState createState() => AddressListTileState();
}

class AddressListTileState extends State<AddressNodeTile> {
  Widget _iconAddress() {
    if (widget.address.nodeStatusOn) {
      return BlinkingIcon(icon: Assets.iconsNode);
    }

    return SvgPicture.asset(
      Assets.iconsClose,
      width: 32,
      height: 32,
      color: Colors.grey,
    );
  }

  String hashObfuscation(String hash) {
    if (hash.length >= 25) {
      return "${hash.substring(0, 9)}...${hash.substring(hash.length - 9)}";
    }
    return hash;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: _iconAddress(),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.address.hash.toString(),
                style: AppTextStyles.walletAddress
                    .copyWith(fontSize: 20, fontFamily: "GilroyRegular"),
              ),

            ]));
  }
}
