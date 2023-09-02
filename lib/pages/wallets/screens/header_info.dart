import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';

class ItemHeaderInfo extends StatelessWidget {
  final String title, value;

  const ItemHeaderInfo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child: TextButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.3),
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Text(
              '$title: $value',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5)
          ],
        ),
      ),
    );
  }
}

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ItemHeaderInfo(
                title: AppLocalizations.of(context)!.price,
                value: "0"),
            ItemHeaderInfo(
                title: AppLocalizations.of(context)!.incoming,
                value: "0"),
            ItemHeaderInfo(
                title: AppLocalizations.of(context)!.outgoing,
                value: "0"),
          ],
        ),
      );
  }
}
