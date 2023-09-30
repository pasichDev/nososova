import 'package:flutter/material.dart';

import '../../../../tiles/dialog_tile.dart';



class DialogMore extends StatelessWidget {

  const DialogMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [

      const SizedBox(height: 16),
      ListView(
        shrinkWrap: true,
        children: [
          buildListTile(Icons.sort, 'Sort', () {}),
          buildListTile(Icons.sort, 'Sort Test', () {}),
          buildListTile(Icons.sort, 'Sort Test Two', () {}),
        ],
      ),
    ]);
  }
}
