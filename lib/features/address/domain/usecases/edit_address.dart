import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/address_repository.dart';

class EditAddress extends UseCase<Unit, EditAddressParams> {
  final AddressRepository repository;
  EditAddress({required this.repository});
  @override
  Future<Either<Failure, Unit>> call(EditAddressParams params) async {
    return await repository.editAddress(addressID: params.id);
  }
}

class EditAddressParams {
  int id;
  EditAddressParams({required this.id});
}
