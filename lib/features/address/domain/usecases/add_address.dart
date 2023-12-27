import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/add_address_model.dart';
import '../repositories/address_repository.dart';

class AddAddress extends UseCase<AddAddressResponse, AddAddressParams> {
  final AddressRepository repository;
  AddAddress({required this.repository});
  @override
  Future<Either<Failure, AddAddressResponse>> call(
      AddAddressParams params) async {
    return await repository.addAddress(params: params);
  }
}

class AddAddressParams {
  String? firstName;
  String? lastName;
  String? address;
  String? mobile;
  String? defaultId;
  String? cityId;

  AddAddressParams({
    this.firstName,
    this.lastName,
    this.address,
    this.mobile,
    this.defaultId,
    this.cityId,
  });
  Map<String, dynamic> toMap() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "address": address,
      "mobile": mobile,
      "default": defaultId,
      "city_id": cityId,
    };
  }
}
