import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/app_data_bloc.dart';
import 'package:nososova/blocs/data_bloc.dart';
import 'package:nososova/blocs/debug_block.dart';
import 'package:nososova/dependency_injection.dart';
import 'package:nososova/l10n/app_localizations.dart';

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DebugBloc>(
            create: (context) {
              final debugBloc = locator<DebugBloc>();
             // dataBloc.add(FetchAddress());
              return debugBloc;
            },
          ),
          BlocProvider<DataBloc>(
            create: (context) {
              final dataBloc = locator<DataBloc>();
              dataBloc.add(FetchAddress());
              return dataBloc;
            },
          ),
          BlocProvider<AppDataBloc>(
            create: (context) {
              final appDataBloc = locator<AppDataBloc>();
           //   appDataBloc.add(StartNode());
              return appDataBloc;
            },
          ),
        ],
        child: const MainPage(),
      ),
    );
  }
}
