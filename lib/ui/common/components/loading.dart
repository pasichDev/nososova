import 'package:flutter/material.dart';

import '../../theme/style/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(padding: EdgeInsets.symmetric(vertical: 50), child: CircularProgressIndicator(
      color: CustomColors.primaryColor,
    )));
  }
}
