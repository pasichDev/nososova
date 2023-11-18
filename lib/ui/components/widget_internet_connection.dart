import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/ui/theme/style/text_style.dart';

import '../../blocs/app_data_bloc.dart';

class StatusNetworkConnection extends StatelessWidget {
  const StatusNetworkConnection({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var oneStart = true;
    ConnectivityResult? statusOld;
    return BlocBuilder<AppDataBloc, AppDataState>(
      builder: (context, state) {
        var status = state.deviceConnectedNetworkStatus;
        if (statusOld != null && statusOld == status) {
          return Container();
        }
        statusOld = status;
        if (status == ConnectivityResult.none) {
          return message("No internet connection", Colors.red);
        }

        Future.delayed(const Duration(seconds: 1), () {
          if (state.deviceConnectedNetworkStatus != ConnectivityResult.none && !oneStart) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Internet connection restored",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleMin
                      .copyWith(fontSize: 18, color: Colors.white),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        });

        oneStart = true;
        return Container();
      },
    );
  }

  Widget message(String message, Color color) {
    return Container(
      color: color,
      width: double.infinity,
      padding: const EdgeInsets.all(6.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style:
            AppTextStyles.titleMin.copyWith(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
