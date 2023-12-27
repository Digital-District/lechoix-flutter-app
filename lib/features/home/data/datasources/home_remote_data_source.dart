import 'package:flutter/foundation.dart';
import '../model/slider_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/entities/cities.dart';

const citiesApi = "cities";
const slidessApi = "slides";

abstract class HomeRemoteDataSource {
  Future<CitiesResponse> getCities();
  Future<HomeSliderResponse> getSlides();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiBaseHelper helper;

  HomeRemoteDataSourceImpl({
    required this.helper,
  });

  //get cities
  @override
  Future<CitiesResponse> getCities() async {
    try {
      final response = await helper.get(
        url: citiesApi,
      );
      if (response["success"] == true) {
        debugPrint("get cities done${response["success"].toString()} ");
        return CitiesResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<HomeSliderResponse> getSlides() async {
    try {
      final response = await helper.get(
        url: slidessApi,
      );
      if (response["success"] == "true") {
        debugPrint("get cities done${response["success"].toString()} ");
        return HomeSliderResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  
}
