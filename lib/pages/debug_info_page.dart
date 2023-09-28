import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/debug_block.dart';

import '../l10n/app_localizations.dart';
import 'components/decoration/standart_gradient_decoration.dart';

class DebugInfoPage extends StatefulWidget {
  const DebugInfoPage({super.key});

  @override
  QRScanScreenState createState() => QRScanScreenState();
}

class QRScanScreenState extends State<DebugInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<DebugBloc, DebugState>(
        builder: (context, state) {
          var debugList = state.debugInfo;
          return Scaffold(
            appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.debugInfo),
                backgroundColor: Colors.transparent,
                flexibleSpace: Container(
                    decoration:
                    const StandartGradientDecoration(borderRadius: null))),
            body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: debugList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text("> ${debugList[index]}"),
                          );
                        },
                      ),
                    ),
                  ],
                )),
          );

        });
      // final appState = Provider.of<AppState>(context, listen: false);

    return Container();
   /* return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.debugInfo),
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
              decoration:
                  const StandartGradientDecoration(borderRadius: null))),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: appState.debugInfo.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text("> ${appState.debugInfo[index]}"),
                    );
                  },
                ),
              ),
            ],
          )),
    );

    */
  }
}
