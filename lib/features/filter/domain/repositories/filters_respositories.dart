import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../filter/data/models/brands_model.dart';
abstract class FiltersRepository {
  Future<Either<Failure, BrandsResponse>> getBrands();
}
