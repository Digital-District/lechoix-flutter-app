import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/usecases/show_category_product.dart';
import '../models/categories_model.dart';
import '../models/show_category_model.dart';
import '../models/subCategories_response.dart';

const categoriesApi = "cats";
const showCategoryApi = "category/";
const subCategoriesApi = "sub-category/";

abstract class CategoriesRemoteDataSource {
  Future<CategoriesResponse> getCategories();
  Future<SubCategoriesByCatResponse> getSubCategoriesByCat({required int id});
  Future<ShowCategoryResponse> showCategoryProduct(
      {required ShowCategoryProductParams params});
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiBaseHelper helper;

  CategoriesRemoteDataSourceImpl({
    required this.helper,
  });

  //get Categories
  @override
  Future<CategoriesResponse> getCategories() async {
    try {
      final response = await helper.get(
        url: categoriesApi,
      );
      if (response["success"] == "true") {
        debugPrint("get Categories done${response["success"].toString()} ");
        return CategoriesResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      debugPrint("Server exception${e.message}");
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ShowCategoryResponse> showCategoryProduct(
      {required ShowCategoryProductParams params}) async {
    try {
      final response = await helper.get(
        url: "$showCategoryApi${params.id}?page=${params.page}",
      );
      if (response["success"] == "true") {
        debugPrint("get Categories done${response["success"].toString()} ");
        return ShowCategoryResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SubCategoriesByCatResponse> getSubCategoriesByCat(
      {required int id}) async {
    try {
      final response = await helper.get(
        url: "$subCategoriesApi$id",
      );
      if (response["success"] == "true") {
        debugPrint("get sub Categories done${response["success"].toString()} ");
        return SubCategoriesByCatResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      debugPrint("Server exception${e.message}");
      throw ServerException(message: e.message);
    }
  }
}
