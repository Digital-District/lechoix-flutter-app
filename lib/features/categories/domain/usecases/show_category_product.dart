import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/show_category_model.dart';
import '../repositories/categories_repository.dart';

class ShowCategoryProduct
    extends UseCase<ShowCategoryResponse, ShowCategoryProductParams> {
  final CategoriesRepository repository;
  ShowCategoryProduct({required this.repository});
  @override
  Future<Either<Failure, ShowCategoryResponse>> call(
      ShowCategoryProductParams params) async {
    return await repository.showCategoryProduct(params: params);
  }
}

class ShowCategoryProductParams {
  int id;
  int page;
  ShowCategoryProductParams({required this.id,required this.page});
}
