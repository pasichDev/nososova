import 'package:flutter/material.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/pages/debug_info_page.dart';
import 'package:nososova/utils/colors.dart';

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
              const Row(
                children: [
                  TagWidget(text: "Block : 12876"),
                  SizedBox(width: 8.0),
                  TagWidget(text: "Status : Connected"),
                  SizedBox(width: 8.0),
                  TagWidget(text: "Time : 12876")
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.computer),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "192.168.22.11:8080",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.bug_report_outlined),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.debugInfo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.navigate_next_outlined)
                    ]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DebugInfoPage()),
                  );
                  //   Navigator.pop(context);
                },
              ),
              const SizedBox(height: 30),
            ]));
  }
}

class TagWidget extends StatelessWidget {
  final String text;

  const TagWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
