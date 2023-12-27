import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/show_category_model.dart';
import '../../data/models/subCategories_response.dart';
import '../usecases/show_category_product.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, CategoriesResponse>> getCategories();
  Future<Either<Failure, SubCategoriesByCatResponse>> getSubCategoriesByCat(
      {required int id});
  Future<Either<Failure, ShowCategoryResponse>> showCategoryProduct(
      {required ShowCategoryProductParams params});
}
