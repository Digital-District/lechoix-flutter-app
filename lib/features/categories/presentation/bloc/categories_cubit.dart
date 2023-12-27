import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../product/data/models/products_response.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/subCategories_response.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_sub_categories.dart';
import '../../domain/usecases/show_category_product.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.getCategories,
    required this.showCategoryProduct,
    required this.subCategories,
  }) : super(CategoriesInitial());

  final GetCategories getCategories;
  final GetSubCategories subCategories;
  final ShowCategoryProduct showCategoryProduct;
  List<CategoryData>? categories = [];
  List<SubCategory>? subCategoriesList = [];
  List<Product>? categoryProducts = [];
  int initIndex = 0;
  int page = 1;

  changeTabIndex(i) {
    initIndex = i;
    if (categories!.isNotEmpty) {
      fShowCategoryproduct(categories![i].id);
    }
  }

  fGetCategories() async {
    emit(GetCategoriesLoading());

    final failOrsuccess = await getCategories(NoParams());
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
        print(fail.message);
      }
      emit(GetCategoriesError());
    }, (success) async {
      emit(GetCategoriesSuccess());
      categories = success.data!;
    });
  }

  fGetSubCategories(id) async {
    emit(GetSubCategoriesLoading());
    final failOrsuccess = await subCategories(SubCategoryParams(id: id));
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      emit(GetSubCategoriesError());
    }, (success) async {
      emit(GetSubCategoriesSuccess());
      subCategoriesList = success.data!;
    });
  }

  emitFreshLoading(id) {
    page = 1;
    // categoryProducts!.clear();
    subCategoriesList!.clear();
    // fShowCategoryproduct(id);
    fGetSubCategories(id);
  }
  emitCatProductFreshLoading(id) {
    page = 1;
    categoryProducts!.clear();
    // emit(SellerProductsLoading(const [], isFirstFetch: currentPage == 1));
    fShowCategoryproduct(id);
  }
  fShowCategoryproduct(id) async {
    if (state is GetCategoryProcuctLoading) return;
    final currentState = state;
    categoryProducts = [];
    if (currentState is GetCategoryProcuctSuccess) {
      categoryProducts = currentState.data;
    }
    emit(GetCategoryProcuctLoading(categoryProducts!, isFirstFetch: page == 1));
    final failOrsuccess = await showCategoryProduct(
        ShowCategoryProductParams(id: id, page: page));
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      emit(GetCategoryProcuctError());
    }, (success) async {
      // categoryProducts = success.data!.data;
      page++;
      log(page.toString());
      final categoryProducts = ((state as GetCategoryProcuctLoading).data);
      categoryProducts.addAll(success.data!.data!);
      emit(GetCategoryProcuctSuccess(data: categoryProducts));
    });
  }
}
