import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/debug_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/dependency_injection.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/pages/main_page_tested.dart';

import 'blocs/events/app_data_events.dart';
import 'generated/assets.dart';

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
            create: (context) => locator<WalletBloc>(),
          ),
          BlocProvider<AppDataBloc>(create: (context) {
            final appDataBloc = locator<AppDataBloc>();
            appDataBloc.add(InitialConnect());
            return appDataBloc;
          }),
        ],
        child: const MainPage(),
      ),
    );
  }
}
