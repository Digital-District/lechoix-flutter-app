import 'package:lechoix/base/base_bloc.dart';
import 'package:lechoix/features/auth/data/datasources/AuthRepo.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthRequestModel.dart';

class ForgotPasswordBloc extends BaseBloc {
  final AuthRepo _repo = AuthRepo();

  ForgotPasswordBloc(super.view);

  Future<bool> forgetPassword(AuthRequestModel model) async {
    view.showProgress();
    try {
      // var baseResponse = 
      await _repo.forgetPassword(model);
      view.hideProgress();
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  @override
  void onDispose() {
    _repo.dispose();
  }
}
