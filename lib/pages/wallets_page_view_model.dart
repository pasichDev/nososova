import 'package:flutter/foundation.dart';
import 'package:nososova/database/models/app_user_information.dart';

class WalletsPageViewModel extends ChangeNotifier {




  AppUserInformation _userInfo = AppUserInformation();

  int get totalBalance => _userInfo.totalBalance;
  int get block => _userInfo.block;
  int get price => _userInfo.price;
  int get totalIncoming => _userInfo.totalIncoming;
  int get totalOutgoing => _userInfo.totalOutgoing;


  void updateUserInfo(AppUserInformation updatedUserInfo) {
    _userInfo = updatedUserInfo;
    notifyListeners();

  }
}
