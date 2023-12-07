import 'package:lechoix/base/base_bloc.dart';
import 'package:lechoix/features/auth/data/datasources/AuthRepo.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthRequestModel.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthResponseModel.dart';

class LoginBloc extends BaseBloc {
  final AuthRepo _repo = AuthRepo();

  LoginBloc(super.view);

  Future<AuthResponseModel?> login(AuthRequestModel model) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.login(model);
      view.hideProgress();
      return baseResponse.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }

  @override
  void onDispose() {
    _repo.dispose();
  }
}
