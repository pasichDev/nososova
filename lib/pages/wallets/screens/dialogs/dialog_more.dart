import 'package:flutter/material.dart';
import 'package:nososova/pages/components/item_dialog.dart';

class DialogMore extends StatelessWidget {

  const DialogMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [

      const SizedBox(height: 16),
      ListView(
        shrinkWrap: true,
        children: [
          buildListItem(Icons.sort, 'Sort', () {}),
          buildListItem(Icons.sort, 'Sort Test', () {}),
          buildListItem(Icons.sort, 'Sort Test Two', () {}),
        ],
      ),
    ]);
  }
}
