import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';

class DialogDebugInfo extends StatelessWidget {
  const DialogDebugInfo({Key? key}) : super(key: key);

  final TextStyle _smallTextSize = const TextStyle(fontSize: 12.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.debugInfo,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 30),
            ]));
  }
}
