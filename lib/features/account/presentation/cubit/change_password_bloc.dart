import 'package:easy_localization/easy_localization.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/cache/user_cache.dart';
import '../../data/datasources/UserRepo.dart';

class ChangePasswordBloc extends BaseBloc {
  final UserRepo _userRepo = UserRepo();

  ChangePasswordBloc(super.view);

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    view.showProgress();
    try {
      var response = await _userRepo.changePassword(oldPassword, newPassword);
      view.showSuccessMsg(tr("Password changed successfully"));
      view.hideProgress();
      if (response.data != null) {
        UserCache.instance.setUser(response.data);
        return true;
      }
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  @override
  void onDispose() {
    _userRepo.dispose();
  }
}
