import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/cities.dart';
import '../repositories/home_repository.dart';

class GetCities extends UseCase<CitiesResponse, NoParams> {
  final HomeRepository repository;
  GetCities({required this.repository});
  @override
  Future<Either<Failure, CitiesResponse>> call(NoParams params) async {
    return await repository.getCities();
  }
}
