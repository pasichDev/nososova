import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/theme/anim/blinkin_widget.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../generated/assets.dart';
import '../../utils/noso/model/address_object.dart';
import '../theme/style/icons_style.dart';

class AddressListTile extends StatefulWidget {
  final VoidCallback onLong;
  final VoidCallback onTap;
  final Address address;

  const AddressListTile({
    Key? key,
    required this.address,
    required this.onLong,
    required this.onTap,
  }) : super(key: key);

  @override
  AddressListTileState createState() => AddressListTileState();
}

class AddressListTileState extends State<AddressListTile> {
  Widget _iconAddress() {
    if (widget.address.nodeAvailable) {
      return SvgPicture.asset(
        Assets.iconsNode,
        width: 32,
        height: 32,
        color: Colors.grey,
      );
    } else if (widget.address.incoming > 0) {
      return BlinkingWidget(
          widget: AppIconsStyle.icon3x2(Assets.iconsInput),
          startBlinking: true,
          duration: 500);
    }
    if (widget.address.outgoing > 0) {
      return BlinkingWidget(
          widget: AppIconsStyle.icon3x2(Assets.iconsOutput),
          startBlinking: true,
          duration: 500);
    }

    return SvgPicture.asset(
      Assets.iconsCard,
      width: 32,
      height: 32,
      color: Colors.grey,
    );
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
              widget.address.nameAddressPublic,
              style: AppTextStyles.itemStyle.copyWith(fontSize: 20),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.address.balance.toStringAsFixed(3),
                    style: AppTextStyles.walletAddress,
                  ),
                  if (widget.address.incoming > 0)
                    Text(
                      "+ ${widget.address.incoming}",
                      style: AppTextStyles.itemStyle.copyWith(
                          fontSize: 16,
                          fontFamily: "GilroySemiBold",
                          color: Colors.green),
                    ),
                  const SizedBox(width: 5),
                  if (widget.address.outgoing > 0)
                    Text(
                      "- ${widget.address.outgoing}",
                      style: AppTextStyles.itemStyle.copyWith(
                          fontSize: 16,
                          fontFamily: "GilroySemiBold",
                          color: Colors.red),
                    ),
                ]),
          ],
        ),
        onLongPress: widget.onLong,
        onTap: widget.onTap);
  }
}
