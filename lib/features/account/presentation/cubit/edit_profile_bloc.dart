import 'package:easy_localization/easy_localization.dart';
import 'package:lechoix/features/account/data/datasources/UserRepo.dart';

// import 'package:image_picker/image_picker.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/cache/user_cache.dart';

class EditProfileBloc extends BaseBloc {
  final UserRepo _userRepo = UserRepo();

  EditProfileBloc(super.view);

  Future<bool> editProfile(
    String firstName,
    String lastName,
  ) async {
    view.showProgress();
    try {
      var response = await _userRepo.editProfile(firstName, lastName);
      view.showSuccessMsg(tr("Profile Updated Successfully"));
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

  // Future<bool> changeAvatar(XFile image) async {
  //   view.showProgress();
  //   try {
  //     var response = await _userRepo.changeAvatar(image);
  //     view.hideProgress();
  //     if (response.data != null) {
  //       UserCache.instance.setUser(response.data);
  //       return true;
  //     }
  //   } catch (e) {
  //     handleError(e);
  //   }
  //   return false;
  // }

  Future<bool> deleteAccount() async {
    view.showProgress();
    try {
      await _userRepo.deleteAccount();
      view.hideProgress();
      return true;
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
