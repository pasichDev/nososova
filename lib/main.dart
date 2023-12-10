import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/coin_info_bloc.dart';
import 'package:nososova/blocs/debug_bloc.dart';
import 'package:nososova/blocs/node_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/dependency_injection.dart';
import 'package:nososova/l10n/app_localizations.dart';

import 'blocs/events/app_data_events.dart';
import 'blocs/events/wallet_events.dart';
import 'generated/assets.dart';
import 'ui/pages/main_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.nososova);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    FontLoader("GilroyHeavy").addFont(rootBundle.load(Assets.fontsGilroyHeavy));
    FontLoader("GilroyBold").addFont(rootBundle.load(Assets.fontsGilroyBold));
    FontLoader("GilroyRegular")
        .addFont(rootBundle.load(Assets.fontsGilroyRegular));
    FontLoader("GilroySemiBold")
        .addFont(rootBundle.load(Assets.fontsGilroyRegular));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DebugBloc>(create: (context) => locator<DebugBloc>()),
          BlocProvider<WalletBloc>(
            create: (context) {
              final dataBloc = locator<WalletBloc>();
              dataBloc.add(FetchAddress());
              return dataBloc;
            },
          ),
          BlocProvider<AppDataBloc>(create: (context) {
            final appDataBloc = locator<AppDataBloc>();
            appDataBloc.add(InitialConnect());
            return appDataBloc;
          }),
          BlocProvider<CoinInfoBloc>(
              create: (context) => locator<CoinInfoBloc>()),
          BlocProvider<NodeBloc>(create: (context) {
            final nodeBlock = locator<NodeBloc>();
            return nodeBlock;
          }),
      //  BlocProvider<HistoryTransactionsBloc>(create: (context) => locator<HistoryTransactionsBloc>()),

        ],
        child: const MainPage(),
      ),
    );
  }
}
