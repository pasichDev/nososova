import 'package:flutter/material.dart';
import 'package:nososova/pages/components/item_dialog.dart';
import 'package:nososova/pages/qr_scan_page.dart';

class DialogImport extends StatelessWidget {
  const DialogImport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListView(
        shrinkWrap: true,
        children: [
          buildListItem(Icons.qr_code, 'Scan QR Code', ()=>Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRScanScreen()),
          )),
          buildListItem(Icons.file_copy_outlined, 'Selected file .pkw', () {}),
        ],
      ),
    ]);
  }
}
