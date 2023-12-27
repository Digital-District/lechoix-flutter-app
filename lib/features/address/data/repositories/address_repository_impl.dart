import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/add_address.dart';
import '../datasources/address_datasource.dart';
import '../models/add_address_model.dart';
import '../models/myAddress_model.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remote;

  AddressRepositoryImpl({
    required this.remote,
  });

  @override
  Future<Either<Failure, AddAddressResponse>> addAddress({required AddAddressParams params})async {
    try {
      final response = await remote.addAddress(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deleteAddress({required int addressID})async {
    try {
      final response = await remote.deleteAddress(addressID: addressID);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> editAddress({required int addressID})async {
    try {
      final response = await remote.editAddress(addressID: addressID);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, MyAddressResponse>> getMyAddresses()async {
    try {
      final response = await remote.getMyAddresses();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
