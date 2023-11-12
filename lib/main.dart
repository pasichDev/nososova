import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/dependency_injection.dart';
import 'package:nososova/l10n/app_localizations.dart';

import 'blocs/events/app_data_events.dart';
import 'blocs/events/wallet_events.dart';
import 'main_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    FontLoader("GilroyHeavy").addFont(rootBundle.load("assets/fonts/Gilroy-Heavy.ttf"));
    FontLoader("GilroyBold").addFont(rootBundle.load("assets/fonts/Gilroy-Bold.ttf"));
    FontLoader("GilroyRegular").addFont(rootBundle.load("assets/fonts/Gilroy-Regular.ttf"));
    FontLoader("GilroySemiBold").addFont(rootBundle.load("assets/fonts/Gilroy-SemiBold.ttf"));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
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
        ],
        child: const MainPage(),
      ),
    );
  }
}
