import 'dart:async';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/cache/user_cache.dart';
import '../../../data/datasources/AuthRepo.dart';
import '../../../domain/entities/auth/AuthRequestModel.dart';

class OTPVerifyBloc extends BaseBloc {
  final AuthRepo _repo = AuthRepo();

  OTPVerifyBloc(super.view);

  StreamController<int> timerController = StreamController();
  int timerCount = 119;
  late Timer _timer;

  void startTimer() {
    timerCount = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        timerController.add(timerCount);
        if (timerCount == 0) {
          timer.cancel();
        } else {
          timerCount--;
        }
      },
    );
  }

  Future<bool> verifyPhone(AuthRequestModel model) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.verifyPhone(model);
      view.hideProgress();
      UserCache.instance.setUser(baseResponse.data);
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<bool> passwordCheckCode(AuthRequestModel model) async {
    view.showProgress();
    try {
      var res = await _repo.passwordCheckCode(model);
      view.hideProgress();
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<bool> forgetPassword(AuthRequestModel model) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.forgetPassword(model);
      view.hideProgress();
      view.showSuccessMsg("${baseResponse.message}");
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<bool> resendCode(AuthRequestModel model) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.resendCode(model);
      view.hideProgress();
      view.showSuccessMsg("${baseResponse.message}");
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  @override
  void onDispose() {
    _timer.cancel();
    timerController.close();
    _repo.dispose();
  }
}
