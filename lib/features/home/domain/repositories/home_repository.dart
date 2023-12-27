import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/slider_model.dart';
import '../entities/cities.dart';

abstract class HomeRepository {
  Future<Either<Failure, CitiesResponse>> getCities();
  Future<Either<Failure, HomeSliderResponse>> getSlides();
}
