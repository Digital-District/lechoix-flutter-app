import 'dart:async';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/cache/user_cache.dart';
import '../../data/datasources/UserRepo.dart';

class ProfileOTPBloc extends BaseBloc {
  final UserRepo _userRepo = UserRepo();

  ProfileOTPBloc(super.view);

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

  Future<bool> changePhone(
      String phone, String code, int phoneCountryCodeId) async {
    view.showProgress();
    try {
      var response =
          await _userRepo.changePhone(phone, code, phoneCountryCodeId);
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

  Future<bool> changeEmail(String email, String code) async {
    view.showProgress();
    try {
      var response = await _userRepo.changeEmail(email, code);
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
    _timer.cancel();
    timerController.close();
    _userRepo.dispose();
  }
}
