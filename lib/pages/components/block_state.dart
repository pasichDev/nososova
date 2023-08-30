import 'package:flutter/material.dart';
import 'package:nososova/pages/wallets_page_view_model.dart';
import 'package:provider/provider.dart';

class BlockState extends StatelessWidget {
  const BlockState({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WalletsPageViewModel>(context);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Text(
              viewModel.block.toString(),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )
          ],
        ));
  }
}
