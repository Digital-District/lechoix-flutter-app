import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/subCategories_response.dart';
import '../repositories/categories_repository.dart';

class GetSubCategories
    extends UseCase<SubCategoriesByCatResponse, SubCategoryParams> {
  final CategoriesRepository repository;
  GetSubCategories({required this.repository});
  @override
  Future<Either<Failure, SubCategoriesByCatResponse>> call(
      SubCategoryParams params) async {
    return await repository.getSubCategoriesByCat(id: params.id);
  }
}

class SubCategoryParams {
  int id;
  SubCategoryParams({required this.id});
}
