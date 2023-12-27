import 'dart:async';

import '../../../../core/base/base_bloc.dart';
import '../../../auth/data/datasources/AuthRepo.dart';

class DynamicHTMLBloc extends BaseBloc {
  final AuthRepo _repo = AuthRepo();
  String myPageKey = "";

  DynamicHTMLBloc(super.view, String page) {
    myPageKey = page;
    getData();
  }

  StreamController<String?> controller = StreamController();

  void getData() {
    controller.add(null);
    _repo.getHTMLPage(myPageKey).then((baseResponse) {
      if (baseResponse.data?.content?.isNotEmpty == true) {
        controller.add(baseResponse.data?.content ?? "");
      }
    }).onError((error, stackTrace) {
      handleStreamError(error, controller);
    });
  }

  @override
  void onDispose() {
    controller.close();
    _repo.dispose();
  }
}
