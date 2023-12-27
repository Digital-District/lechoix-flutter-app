import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/brands_model.dart';
import '../repositories/filters_respositories.dart';

class GetBrands extends UseCase<BrandsResponse, NoParams> {
  final FiltersRepository repository;
  GetBrands({required this.repository});
  @override
  Future<Either<Failure, BrandsResponse>> call(NoParams params) async {
    return await repository.getBrands();
  }
}
