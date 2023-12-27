import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/myAddress_model.dart';
import '../repositories/address_repository.dart';

class GetMyAddresses extends UseCase<MyAddressResponse, NoParams> {
  final AddressRepository repository;
  GetMyAddresses({required this.repository});
  @override
  Future<Either<Failure, MyAddressResponse>> call(NoParams params) async {
    return await repository.getMyAddresses();
  }
}
