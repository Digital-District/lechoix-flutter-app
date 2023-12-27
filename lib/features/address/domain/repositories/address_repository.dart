import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/add_address_model.dart';
import '../../data/models/myAddress_model.dart';
import '../usecases/add_address.dart';

abstract class AddressRepository {
  Future<Either<Failure, MyAddressResponse>> getMyAddresses();
  Future<Either<Failure, Unit>> editAddress({required int addressID});
  Future<Either<Failure, String>> deleteAddress({required int addressID});
  Future<Either<Failure, AddAddressResponse>> addAddress({required AddAddressParams params});
}
