import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noso_dart/models/address_object.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/config/responsive.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../../blocs/events/wallet_events.dart';
import '../../../blocs/wallet_bloc.dart';
import '../../theme/style/text_style.dart';

typedef OnCancelButtonPressed = void Function();
typedef OnAddToWalletButtonPressed = void Function();

final class DialogImportAddress extends StatefulWidget {
  final List<AddressObject> address;

  const DialogImportAddress({super.key, required this.address});

  @override
  DialogImportAddressState createState() => DialogImportAddressState();
}

class DialogImportAddressState extends State<DialogImportAddress> {
  late WalletBloc walletBloc;
  final List<AddressObject> selectedItems = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
  }

  /// TODO Баг: Якщо один елемент в списку то список максимально ростягнути багато пустого місця
  @override
  Widget build(BuildContext context) {
    var addresses = widget.address;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Responsive.isMobile(context)) const SizedBox(height: 60),
          Text(
            AppLocalizations.of(context)!.foundAddresses,
            style: AppTextStyles.dialogTitle,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: addresses.length,
              itemBuilder: (BuildContext context, int index) {
                final item = addresses[index];
                final isSelected = selectedItems.contains(item);

                return ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(item.hash,
                      style: AppTextStyles.itemStyle.copyWith(fontSize: 16)),
                  leading: Checkbox(
                    activeColor: CustomColors.primaryColor,
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: IconButton(
              icon: Icon(!selectAll ? Icons.select_all : Icons.deselect),
              onPressed: () {
                setState(() {
                  if (selectAll) {
                    selectedItems.clear();
                  } else {
                    selectedItems.addAll(addresses);
                  }
                  selectAll = !selectAll;
                });
              },
            ),
            title: Text(
              "${AppLocalizations.of(context)!.searchAddressResult}: ${addresses.length}",
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.negativeBalance,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: AppTextStyles.walletAddress
                            .copyWith(color: Colors.white))),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                ),
                onPressed: () {
                  if (selectedItems.isNotEmpty) {
                    walletBloc.add(AddAddresses(selectedItems));
                  }
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(AppLocalizations.of(context)!.addToWallet,
                      style: AppTextStyles.walletAddress
                          .copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
