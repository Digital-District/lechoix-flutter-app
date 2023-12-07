import 'package:lechoix/cache/user_cache.dart';
import '../../../../base/base_bloc.dart';

class NotificationBloc extends BaseBloc {
  // final NotificationRepo _repo = NotificationRepo();

  NotificationBloc(super.view);

  // Future<bool> updateNotificationToken() async {
  //   view.showProgress();
  //   try {
  //     await _repo.updateNotificationToken({"token" : UserCache.instance.getFCMToken()});
  //     view.hideProgress();
  //     UserCache.instance.setAllowFCMStatus(true);
  //     return true;
  //   } catch (e) {
  //     handleError(e);
  //   }
  //   return false;
  // }
  // Future<bool> deleteNotificationToken() async {
  //   view.showProgress();
  //   try {
  //      await _repo.deleteNotificationToken();
  //     view.hideProgress();
  //      UserCache.instance.setAllowFCMStatus(false);
  //      return true;
  //   } catch (e) {
  //     handleError(e);
  //   }
  //   return false;
  // }




  @override
  void onDispose() {
    // _repo.dispose();
  }
}
