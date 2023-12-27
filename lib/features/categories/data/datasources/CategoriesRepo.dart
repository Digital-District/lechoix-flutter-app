import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/Enumeration.dart';

import '../../../../core/base/base_repo.dart';
import '../../../../data/CategoryModel.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../../data/home/HomeResponse.dart';
import '../../../../data/response/graphql_countries.dart';

class CategoriesRepo extends BaseRepo {
  Future<BaseResponse<CategoryResponse>> getCategories(
      Map<String, dynamic> param) async {
    // await query(categoriesQuery, {});
    return networkManager.request<CategoryResponse>(
      Endpoints.getCategories,
      Method.GET,
      data: param,
    );
  }

  Future<BaseResponse<HomeResponse>> getHomeCategories(int categoryId) async {
    String url = "${Endpoints.getCategories}/$categoryId";
    // await query(categoriesQuery, {});
    return networkManager.request<HomeResponse>(
      url,
      Method.GET,
    );
  }

  Future<dynamic> query(String document, Map<String, dynamic>? input) async {
    final QueryResult result = await client.query(QueryOptions(
      document: gql(document),
      variables: input ?? {},
      onComplete: (data) => log(data.toString()),
      parserFn: (data) => CountriesResponse(
        data: data == null ? null : CountriesData.fromMap(data),
      ),
    ));
    final resp = result.data;
    final resParsed = result.parsedData as CountriesResponse;
    log("GRAPHQL Countries QUERY ${resParsed.data!.countries!.first.fullNameEnglish}");
    return resp;
    // if (resp is Fragment$LoginSuccess) {
    //   _auth = Auth.fromJson(resp.toJson());
    //   storageService.storeAuthData(_auth!);
    //   notifyListeners();
    // } else {
    //   throw gqlErrorHandler(result.exception);
    // }
  }
}
