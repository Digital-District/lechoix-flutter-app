import 'package:rxdart/rxdart.dart';

import '../../core/base/base_bloc.dart';
import '../../core/cache/user_cache.dart';

class HostBloc extends BaseBloc {
  static BehaviorSubject<int> cartCountController = BehaviorSubject();

  HostBloc(super.view) {
    cartCountController = BehaviorSubject();
  }

  static updateCartCount() {
    if (cartCountController.isClosed) {
      cartCountController = BehaviorSubject();
    }
    print("Hello Bloc ${UserCache.instance.getCartCount()}");

    cartCountController.add(UserCache.instance.getCartCount());
  }

  @override
  void onDispose() {
    cartCountController.close();
  }
}
