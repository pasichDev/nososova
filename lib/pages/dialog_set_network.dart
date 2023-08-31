import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';

class DialogSetNetwork extends StatelessWidget {
  const DialogSetNetwork({Key? key}) : super(key: key);

  final TextStyle _smallTextSize = const TextStyle(fontSize: 12.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.titleSetNetwork,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text("Status : ok"),
              Text("Block : 12876"),

              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.computer),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("192.168.22.11:8080", style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status: Connected",
                                    style: _smallTextSize,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "Ping: 32ms",
                                    style: _smallTextSize,
                                  )
                                ])
                          ]),
                      const Icon(Icons.navigate_next_outlined)
                    ]),
                onTap: (){},
              ),
              const SizedBox(height: 30),

            ]));
  }
}
