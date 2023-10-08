import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nososova/l10n/app_localizations.dart';
import 'package:nososova/ui/theme/style/colors.dart';

import '../../blocs/events/wallet_events.dart';
import '../../blocs/wallet_bloc.dart';
import '../../utils/noso/src/address_object.dart';
import '../theme/style/text_style.dart';

typedef OnCancelButtonPressed = void Function();
typedef OnAddToWalletButtonPressed = void Function();

final class DialogImportAddress extends StatefulWidget {
  final List<Address> address;

  const DialogImportAddress({super.key, required this.address});

  @override
  DialogImportAddressState createState() => DialogImportAddressState();
}

class DialogImportAddressState extends State<DialogImportAddress> {
  late WalletBloc walletBloc;
  final List<Address> selectedItems = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    walletBloc = BlocProvider.of<WalletBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    var addresses = widget.address;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.foundAddresses,
            style: AppTextStyles.dialogTitle,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (BuildContext context, int index) {
                final item = addresses[index];
                final isSelected = selectedItems.contains(item);

                return ListTile(
                  title: Text(item.hash),
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
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancel),
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
                child: Text(AppLocalizations.of(context)!.addToWallet),
              ),
              // const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
