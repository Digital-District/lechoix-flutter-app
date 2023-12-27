import 'dart:async';

import 'package:lechoix/features/address/data/datasources/AddressRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../data/address/AddressModel.dart';

class AddressBloc extends BaseBloc {
  final AddressRepo _repo = AddressRepo();

  AddressBloc(super.view);

  StreamController<List<AddressModel>?> controller = StreamController();

  void getMyAddress() {
    controller.add(null);
    _repo.getMyAddress().then((baseResponse) {
      controller.add(baseResponse.data?.addresses);
    }).onError((error, stackTrace) {
      handleStreamError(error, controller);
    });
  }

  Future<bool> setDefault(int addressId) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.setDefault(addressId);
      view.showSuccessMsg(baseResponse.message ?? "");
      view.hideProgress();
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  @override
  void onDispose() {
    controller.close();
    _repo.dispose();
  }
}
