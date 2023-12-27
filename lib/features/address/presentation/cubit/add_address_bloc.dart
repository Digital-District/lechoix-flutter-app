import 'dart:async';

import 'package:lechoix/features/address/data/datasources/AddressRepo.dart';
import 'package:lechoix/features/splash/presentation/cubit/ConfigRepo.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../data/address/AddAddressRequestModel.dart';
import '../../../../data/address/locations/LocationsResponse.dart';
import '../../../../data/base/ErrorModel.dart';

class AddAddressBloc extends BaseBloc {
  final AddressRepo _repo = AddressRepo();
  final ConfigRepo _configRepo = ConfigRepo();

  ErrorResponse? _errorResponse;

  AddAddressBloc(super.view) {
    getLocations();
  }

  StreamController<LocationsResponse?> locationsController = StreamController();

  Future<bool> addAddress(AddAddressRequestModel model) async {
    _errorResponse = null;
    view.showProgress();
    try {
      var baseResponse = await _repo.addAddress(model);
      view.hideProgress();
      view.showSuccessMsg(baseResponse.message ?? "");
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<bool> updateAddress(
      AddAddressRequestModel model, int addressId) async {
    _errorResponse = null;
    view.showProgress();
    try {
      var baseResponse = await _repo.updateAddress(model, addressId);
      view.hideProgress();
      view.showSuccessMsg(baseResponse.message ?? "");
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  Future<bool> deleteAddress(int addressId) async {
    view.showProgress();
    try {
      var baseResponse = await _repo.deleteAddress(addressId);
      view.showSuccessMsg(baseResponse.message ?? "");
      view.hideProgress();
      return true;
    } catch (e) {
      handleError(e);
    }
    return false;
  }

  String? getValidationError(String key) {
    return _errorResponse?.getError(key);
  }

  void getLocations() async {
    locationsController.add(null);
    _configRepo.getLocations().then((value) {
      locationsController.add(value.data);
    }).onError((error, stackTrace) {
      handleStreamError(error, locationsController);
    });
  }

  @override
  void onError(ErrorResponse errorModel) {
    view.hideProgress();
    _errorResponse = errorModel;
  }

  @override
  void onDispose() {
    _repo.dispose();
    _configRepo.dispose();
  }
}
