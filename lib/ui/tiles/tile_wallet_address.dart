import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nososova/ui/pages/addressInfo/address_info_page.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../generated/assets.dart';
import '../../utils/noso/src/address_object.dart';

class AddressListTile extends StatefulWidget {
  final VoidCallback onButtonClick;
  final Address address;

  const AddressListTile({
    Key? key,
    required this.address,
    required this.onButtonClick,
  }) : super(key: key);

  @override
  AddressListTileState createState() => AddressListTileState();
}

class AddressListTileState extends State<AddressListTile> {
  Widget _iconAddress() {
    if (widget.address.nodeOn) {
      return SvgPicture.asset(
        Assets.iconsNode,
        width: 28,
        height: 28,
        color: Colors.grey,
      );
    } else if (widget.address.incoming > 0) {
      return BlinkingIcon(icon: Assets.iconsInput);
    }
    if (widget.address.outgoing > 0) {
      return BlinkingIcon(icon: Assets.iconsOutput);
    }

    return SvgPicture.asset(
      Assets.iconsCard,
      width: 28,
      height: 28,
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
            hashObfuscation(widget.address.hash.toString()),
            style: AppTextStyles.walletAddress
                .copyWith(fontSize: 20, fontFamily: "GilroyRegular"),
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
      onLongPress: widget.onButtonClick,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressInfoPage(address: widget.address),
        ),
      ),
    );
  }
}

class BlinkingIcon extends StatefulWidget {
  String icon;

  BlinkingIcon({super.key, required this.icon});

  @override
  BlinkingIconState createState() => BlinkingIconState();
}

class BlinkingIconState extends State<BlinkingIcon> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    startBlinking();
  }

  void startBlinking() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: SvgPicture.asset(
        widget.icon,
        width: 28,
        height: 28,
        color: Colors.grey,
      ),
    );
  }
}
