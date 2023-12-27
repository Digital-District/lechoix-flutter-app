import '../../../../core/base/base_bloc.dart';
import '../../data/datasources/UserRepo.dart';

class ChangePhoneBloc extends BaseBloc {
  final UserRepo _userRepo = UserRepo();

  ChangePhoneBloc(super.view);

  Future<bool> requestChangePhone(String phone, int phoneCountryCodeId) async {
    view.showProgress();
    try {
      var response =
          await _userRepo.requestChangePhone(phone, phoneCountryCodeId);
      view.showSuccessMsg(response.message ?? "");
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
