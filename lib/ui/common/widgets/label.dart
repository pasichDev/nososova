import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

class Label extends StatelessWidget {
  final String text;
  final Widget? widget;

  const Label({Key? key, this.text = "", this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: widget ??
          Text(
            text,
            style: AppTextStyles.itemStyle.copyWith(fontSize: 14),
          ),
    );
  }
}
