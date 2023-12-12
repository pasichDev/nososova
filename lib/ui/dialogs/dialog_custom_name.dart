import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/blocs/wallet_bloc.dart';
import 'package:nososova/utils/noso/src/address_object.dart';
import 'package:nososova/utils/status_api.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/const/const.dart';
import '../theme/decoration/textfield_decoration.dart';
import '../theme/style/colors.dart';
import '../theme/style/text_style.dart';


class DialogCustomName extends StatefulWidget {
  final Address address;

  const DialogCustomName({super.key, required this.address});

  @override
  _DialogCustomNameState createState() => _DialogCustomNameState();
}

/// TODO Встановити комісію транзакції
class _DialogCustomNameState extends State<DialogCustomName> {
  bool isFinished = false;
  bool isActiveButtonSend = false;
  ApiStatus statusRename = ApiStatus.connected;

  late TextEditingController customNameController;
  late WalletBloc walletBloc;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
    customNameController =
        TextEditingController(text: widget.address.custom ?? "");

    walletBloc.getAliasResult.listen((result) {

    });
  }

  @override
  Widget build(BuildContext xx) {
    return LayoutBuilder(builder: (xx, _) {

      return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(xx).viewInsets.bottom),
          child: _body());
    });
  }

  /**
   * Відправляжм месендж
   * Обробляєм в блоці
   * Блок відправляє на стрім результ
   * Тут виводим результ
   *
   */

  _body(){
    if(statusRename == ApiStatus.connected){
      return _bodyDialog();
    } else  if(statusRename == ApiStatus.loading){
      return _loadResult();
    } else  if(statusRename == ApiStatus.result){
      return Container();
    }
  }

  _loadResult(){
    return  const Padding(padding: EdgeInsets.all(20), child:
    SizedBox(width: double.infinity, child:
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        CircularProgressIndicator(color: CustomColors.primaryColor),
        SizedBox(height: 100),
      ],)) );
  }

  _bodyDialog(){
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.aliasNameAddress,
            style: AppTextStyles.dialogTitle,
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.aliasMessage,
            style: AppTextStyles.itemStyle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TextField(
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@*+\-_:]')),
              ],
              controller: customNameController,
              style: AppTextStyles.textFieldStyle,
              onChanged: (text) => _checkAliasText(text),
              decoration: AppTextFiledDecoration.defaultDecoration(
                  AppLocalizations.of(context)!.alias)),
          const SizedBox(height: 20),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.commission,
                  style: AppTextStyles.walletAddress.copyWith(
                      color: Colors.black.withOpacity(1), fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  (Const.ComisionCustom).toStringAsFixed(8),
                  style: AppTextStyles.walletAddress
                      .copyWith(color: Colors.black, fontSize: 18),
                ),
              ]),
          const SizedBox(height: 20),
          Center(child:
          SwipeableButtonView(
            isActive: isActiveButtonSend,
            buttonText: AppLocalizations.of(context)!.save,
            buttonWidget: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
            activeColor: const Color(0xFF2B2F4F),
            isFinished: isFinished,


            onWaitingProcess: () {
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                 // statusRename = ApiStatus.loading;
                  isFinished = true;
                });
              });
            },
            onFinish: () async {
              print("fff");
           /*   await Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: Container()));
              setState(() {
                isFinished = false;
              });

            */
            },
          ),),
        ],
      ),
    );
  }

  _checkAliasText(String text) {
    setState(() {
      if (text == widget.address.custom || text.length < 3 || text.length > 32) {
        isActiveButtonSend = false;
      } else {
        isActiveButtonSend = true;
      }
    });
  }

}
