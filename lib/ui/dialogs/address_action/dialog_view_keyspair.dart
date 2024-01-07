import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/address_wallet.dart';
import '../../theme/style/text_style.dart';

class DialogViewKeysPair extends StatefulWidget {
  final Address address;

  const DialogViewKeysPair({super.key, required this.address});

  @override
  State createState() => DialogViewKeysPairState();
}

class DialogViewKeysPairState extends State<DialogViewKeysPair> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemInfo("Hash:", widget.address.hash),
          itemInfo("Public key:", widget.address.publicKey),
          itemInfo("Private key:", widget.address.privateKey)
        ],
      ),
    );
  }

  itemInfo(
    String nameItem,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameItem,
            style: AppTextStyles.itemStyle
                .copyWith(color: Colors.black.withOpacity(0.5), fontSize: 18),
          ),
          InkWell(
              onTap: () => Clipboard.setData(ClipboardData(text: value)),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    value,
                    textAlign: TextAlign.start,
                    style: AppTextStyles.walletAddress
                        .copyWith(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.copy,
                  size: 22,
                ),
              ]))
        ],
      ),
    );
  }
}
