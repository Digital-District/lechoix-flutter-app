import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/model/slider_model.dart';
import '../repositories/home_repository.dart';

class GetSlides extends UseCase<HomeSliderResponse, NoParams> {
  final HomeRepository repository;
  GetSlides({required this.repository});
  @override
  Future<Either<Failure, HomeSliderResponse>> call(NoParams params) async {
    return await repository.getSlides();
  }
}
