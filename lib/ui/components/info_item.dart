import 'package:flutter/material.dart';

import '../theme/style/text_style.dart';

class InfoItem {
  itemInfo(String nameItem, String value, {String twoValue = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                nameItem,
                style: AppTextStyles.itemStyle.copyWith(
                    color: Colors.black.withOpacity(0.5), fontSize: 18),
              )),
          const SizedBox(width: 5),
          Expanded(
              flex: 3,
              child: Row(children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      value,
                      style: AppTextStyles.walletAddress
                          .copyWith(color: Colors.black, fontSize: 18),
                    )),
                if (twoValue.isNotEmpty)
                  Text(
                    " / $twoValue",
                    style: AppTextStyles.walletAddress
                        .copyWith(color: Colors.black, fontSize: 18),
                  )
              ]))
        ],
      ),
    );
  }
}
