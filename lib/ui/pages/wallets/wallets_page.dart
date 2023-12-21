import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/pages/wallets/screens/card_header.dart';
import 'package:nososova/ui/pages/wallets/screens/list_addresses.dart';
import 'package:nososova/ui/pages/wallets/widgets/side_right_bar.dart';
import 'package:nososova/ui/theme/style/colors.dart';
import 'package:nososova/ui/theme/style/icons_style.dart';
import 'package:nososova/utils/noso/model/address_object.dart';

import '../../../generated/assets.dart';
import '../../../utils/const/files_const.dart';
import '../../common/responses_util/response_widget_id.dart';
import '../../common/responses_util/snackbar_message.dart';
import '../../common/route/dialog_router.dart';
import '../../config/responsive.dart';
import '../../dialogs/import_export/dialog_import_address.dart';
import '../../theme/style/dialog_style.dart';
import '../../theme/style/text_style.dart';

class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  WalletsPageState createState() => WalletsPageState();
}

class WalletsPageState extends State<WalletsPage> {
  late WalletBloc walletBloc;
  late StreamSubscription listenResponse;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    _responseListener();
  }

  void _responseListener() {
    listenResponse =
        walletBloc.getResponseStatusStream.listen((response) async {
      if (mounted ||
          ResponseWidgetsIds.idsPageWallet.contains(response.idWidget)) {
        if (response.action == ActionsFileWallet.walletOpen) {
          List<Address> address = response.actionValue;
          showModalBottomSheet(
              shape: DialogStyle.borderShape,
              context: context,
              builder: (_) => BlocProvider.value(
                  value: walletBloc,
                  child: DialogImportAddress(address: address)));
          return;
        }

        await Future.delayed(const Duration(milliseconds: 200));
        SnackBarWidgetResponse(context: GlobalKey<ScaffoldMessengerState>().currentContext ?? context, response: response).get();
      }
    });
  }

  @override
  void dispose() {
    listenResponse.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  const CardHeader(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.myAddresses,
                            style: AppTextStyles.categoryStyle),
                        Row(
                          children: [
                            if (Responsive.isMobile(context))
                              IconButton(
                                  icon: AppIconsStyle.icon2x4(Assets.iconsMenu,
                                      colorCustom: CustomColors.primaryColor),
                                  onPressed: () =>
                                      DialogRouter.showDialogActionWallet(
                                          context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const ListAddresses(),
                ],
              )),
          if (!Responsive.isMobile(context))
            const Expanded(flex: 2, child: SideRightBarDesktop())
        ],
      ),
    );
  }
}
