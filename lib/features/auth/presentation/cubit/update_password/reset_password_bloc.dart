import 'package:lechoix/base/base_bloc.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/features/auth/data/datasources/AuthRepo.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthRequestModel.dart';

class ResetPasswordBloc extends BaseBloc {
  final AuthRepo _repo = AuthRepo();

  ResetPasswordBloc(super.view);

  Future<bool> register(AuthRequestModel model) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.resetPassword(model);
      view.hideProgress();
      UserCache.instance.setUser(baseResponse.data);
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
