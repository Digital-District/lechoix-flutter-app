part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class GetCategoriesLoading extends CategoriesState {}

class GetCategoriesSuccess extends CategoriesState {}

class GetCategoriesError extends CategoriesState {
  // final String error;

  // GetCategoriesError(this.error);
}

class GetSubCategoriesLoading extends CategoriesState {}

class GetSubCategoriesSuccess extends CategoriesState {}

class GetSubCategoriesError extends CategoriesState {
  // final String error;

  // GetCategoriesError(this.error);
}

class GetCategoryProcuctLoading extends CategoriesState {
  final List<Product> data;
  final bool isFirstFetch;

  const GetCategoryProcuctLoading(this.data, {this.isFirstFetch = false});
}

class GetCategoryProcuctLoadingMore extends CategoriesState {
  final bool? loadMore;
  const GetCategoryProcuctLoadingMore(this.loadMore);
}

class GetCategoryProcuctSuccess extends CategoriesState {
  final List<Product> data;

  const GetCategoryProcuctSuccess({required this.data});
}

class GetCategoryProcuctError extends CategoriesState {}
