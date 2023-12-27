import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../models/brands_model.dart';

const brandsApi = "brands";

abstract class FiltersRemoteDataSource {
  Future<BrandsResponse> getBrands();
}

class FiltersRemoteDataSourceImpl implements FiltersRemoteDataSource {
  final ApiBaseHelper helper;

  FiltersRemoteDataSourceImpl({
    required this.helper,
  });

  //get brands
  @override
  Future<BrandsResponse> getBrands() async {
    try {
      final response = await helper.get(
        url: brandsApi,
      );
      if (response["success"] == true) {
        debugPrint("get Brands done${response["success"].toString()} ");
        return BrandsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
