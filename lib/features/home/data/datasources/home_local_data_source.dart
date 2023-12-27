import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/cities.dart';

const citiesCacheConst = "cities_cache";

abstract class HomeLocalDataSource {
  Future<void> cacheCities({required CitiesResponse cities});
  Future<CitiesResponse> getCachedCitiesData();
  Future<void> clearCachedCities();
  Future<void> clearData();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final SharedPreferences sharedPreference;
  HomeLocalDataSourceImpl({required this.sharedPreference});

  @override
  Future<void> cacheCities({required CitiesResponse cities}) async {
    try {
      await sharedPreference.setString(citiesCacheConst, cities.toString());
    } catch (e) {
      throw CacheException();
    }
  }
  
  @override
  Future<CitiesResponse> getCachedCitiesData() async {
    try {
      final userShared = sharedPreference.getString(citiesCacheConst);
      if (userShared != null) {
        final json = jsonDecode(userShared);
        return CitiesResponse.fromJson(json);
      } else {
        throw NoCachedUserException();
      }
    } on NoCachedUserException {
      throw NoCachedUserException();
    } catch (e) {
      throw CacheException();
    }
  }
  
  @override
  Future<void> clearCachedCities() {
    // TODO: implement clearCachedCities
    throw UnimplementedError();
  }
  
  @override
  Future<void> clearData() {
    // TODO: implement clearData
    throw UnimplementedError();
  }

 
  }
