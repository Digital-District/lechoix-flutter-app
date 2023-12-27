import '../../../../../core/base/base_bloc.dart';
import '../../../../../data/base/ErrorModel.dart';
import '../../../data/datasources/AuthRepo.dart';
import '../../../domain/entities/auth/AuthRequestModel.dart';

class RegisterBloc extends BaseBloc {
  final AuthRepo _repo = AuthRepo();
  ErrorResponse? _errorResponse;

  RegisterBloc(super.view);

  Future<bool> register(AuthRequestModel model) async {
    _errorResponse = null;
    view.showProgress();
    try {
      var baseResponse = await _repo.register(model);
      view.hideProgress();
      return true;
    } catch (e) {
      handleError(e);
      return false;
    }
  }

  String? getValidationError(String key) {
    return _errorResponse?.getError(key);
  }

  @override
  void onError(ErrorResponse errorModel) {
    view.hideProgress();
    _errorResponse = errorModel;
  }

  @override
  void onDispose() {
    _repo.dispose();
  }
}
