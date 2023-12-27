import '../../../../core/base/base_bloc.dart';
import '../../data/datasources/UserRepo.dart';

class ChangeEmailBloc extends BaseBloc {
  final UserRepo _userRepo = UserRepo();

  ChangeEmailBloc(super.view);

  Future<bool> requestChangeEmail(String email) async {
    view.showProgress();
    try {
      var response = await _userRepo.requestChangeEmail(email);
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
