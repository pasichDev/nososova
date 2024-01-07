import 'package:flutter/material.dart';

import '../../theme/style/text_style.dart';


class EmptyWidget extends StatelessWidget {
  final String title;
  final String descrpt;

  const EmptyWidget({super.key,  this.title = "", this.descrpt = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title.isNotEmpty)  Text(
            title,
            style: AppTextStyles.dialogTitle,
          ),
          const SizedBox(height: 10),
          if (descrpt.isNotEmpty)
            Text(
              descrpt,
              textAlign: TextAlign.center,
              style: AppTextStyles.itemStyle,
            )
        ],
      )),
    );
  }
}
