import 'package:flutter/material.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';

import '../theme/style/text_style.dart';

class TileConfirmList extends StatefulWidget {
  final String iconData;
  final String title;
  final String confirm;
  final VoidCallback onClick;

  const TileConfirmList(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.confirm,
      required this.onClick})
      : super(key: key);

  @override
  _TileConfirmListStateState createState() => _TileConfirmListStateState();
}

class _TileConfirmListStateState extends State<TileConfirmList> {
  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIconsStyle.icon3x2(widget.iconData,
          colorFilter: ColorFilter.mode(
              _clicked ? CustomColors.negativeBalance : Colors.grey,
              BlendMode.srcIn)),
      title: Text(_clicked ? widget.confirm : widget.title,
          style: _clicked
              ? AppTextStyles.walletAddress
                  .copyWith(color: CustomColors.negativeBalance)
              : AppTextStyles.itemStyle),
      onTap: () {
        setState(() {
          _clicked = !_clicked;
        });

        if (!_clicked) {
          widget.onClick();
        }
      },
    );
  }
}
