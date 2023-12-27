import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/widgets/toast.dart';
import '../../data/models/myAddress_model.dart';
import '../../domain/usecases/add_address.dart';
import '../../domain/usecases/delete_address.dart';
import '../../domain/usecases/edit_address.dart';
import '../../domain/usecases/get_myAddresses.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required this.addAddress,
    required this.editAddress,
    required this.deleteAddress,
    required this.getMyAddresses,
  }) : super(AddressInitial());
  AddAddress addAddress;
  DeleteAddress deleteAddress;
  EditAddress editAddress;
  GetMyAddresses getMyAddresses;
  int selectedIndex = 0;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();

  int? defaultId;
  // TextEditingController cityId = TextEditingController();
  List<AddressModel> myAddress = [];

  fGetMyaddresses() async {
    emit(MyAddressLoading());
    final failOrsuccess = await getMyAddresses(NoParams());
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      emit(MyAddressError());
    }, (success) async {
      myAddress = success.data!;

      emit(MyAddressSuccess(myAddress: success.data!));
    });
  }

  fAddAddress(context, {required int? cityId}) async {
    emit(AddAddressLoading());
    final failOrsuccess = await addAddress(AddAddressParams(
        address: address.text,
        cityId: cityId.toString(),
        defaultId: defaultId.toString(),
        firstName: firstName.text,
        lastName: lastName.text,
        mobile: mobile.text));
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
        showToast(fail.message);
        emit(AddAddressError());
      }
    }, (success) async {
      showToast(success.message);
      address.clear();
      firstName.clear();
      lastName.clear();
      mobile.clear();
      myAddress.add(success.data!);
      emit(AddAddressSuccess());
      emit(MyAddressSuccess(myAddress: myAddress));
    });
  }

  clearAfterOrder() {
    address.clear();
    firstName.clear();
    lastName.clear();
    mobile.clear();
    password.clear();
  }

  fDeleteAddress(context, {required int id, required int index}) async {
    // emit(ProductDetailsLoading());
    final failOrsuccess = await deleteAddress(DeleteAddressParams(id: id));
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
        showToast(fail.message);
      }
    }, (success) async {
      showToast(success);
      myAddress.removeAt(index);
      // Navigation.pop(
      //   context,
      // );
      emit(DeleteAddressSuccess());
      emit(MyAddressSuccess(myAddress: myAddress));
    });
  }

  fEditAddress(id) async {
    // emit(ProductDetailsLoading());
    final failOrsuccess = await editAddress(EditAddressParams(id: id));
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      // emit(ProductDetailsError());
      // emit(GetRegisterParametersErrorState());
    }, (success) async {
      // product = success.data!;
      // emit(ProductDetailsSuccess());
    });
  }

  selectNewIndex(index) {
    emit(ChangeMyAddressIndex(index: index));
    selectedIndex = index;
    emit(MyAddressSuccess(myAddress: myAddress));
  }
}
