import 'dart:async';

import 'package:lechoix/features/categories/data/datasources/CategoriesRepo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/cache/user_cache.dart';
import '../../../../../data/home/HomeResponse.dart';

class HomeBloc extends BaseBloc {
  HomeBloc(super.view) {
    getHomeData();
  }
  final CategoriesRepo _categoriesRepo = CategoriesRepo();
  StreamController<HomeResponse?> homeController = StreamController();

  void getHomeData() async {
    // grql = GraphqlRepositories(view);
    // final resp = await _categoriesRepo.query(categoriesQuery, {});
    // CountriesResponse res = CountriesResponse.fromMap(resp!);
    // log(res.data!.countries!.first.fullNameEnglish!);
    homeController.add(null);
    _categoriesRepo
        .getHomeCategories(UserCache.instance.getCategoryId())
        .then((response) {
      homeController.add(response.data);
    }).onError((error, stackTrace) {
      handleStreamError(error, homeController);
    });
  }

//  Future<dynamic> query(String document, Map<String, dynamic>? input) async {
//     final result = await client.query(QueryOptions(
//       document: gql(document),
//       variables: input ?? {},
//     ));
//     final resp = result.parsedData;
//     log("GRAPHQL CATEGORIES QUERY"+resp.toString());
//     view.showSuccessMsg(resp.toString());
//     return resp;
  // if (resp is Fragment$LoginSuccess) {
  //   _auth = Auth.fromJson(resp.toJson());
  //   storageService.storeAuthData(_auth!);
  //   notifyListeners();
  // } else {
  //   throw gqlErrorHandler(result.exception);
  // }
  // }
  @override
  void onDispose() {
    _categoriesRepo.dispose();
    homeController.close();
  }
}
