import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/address_repository.dart';

class DeleteAddress extends UseCase<String, DeleteAddressParams> {
  final AddressRepository repository;
  DeleteAddress({required this.repository});
  @override
  Future<Either<Failure, String>> call(DeleteAddressParams params) async {
    return await repository.deleteAddress(addressID: params.id);
  }
}

class DeleteAddressParams {
  int id;
  DeleteAddressParams({required this.id});
}
