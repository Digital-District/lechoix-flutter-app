import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/categories_model.dart';
import '../repositories/categories_repository.dart';

class GetCategories extends UseCase<CategoriesResponse, NoParams> {
  final CategoriesRepository repository;
  GetCategories({required this.repository});
  @override
  Future<Either<Failure, CategoriesResponse>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
