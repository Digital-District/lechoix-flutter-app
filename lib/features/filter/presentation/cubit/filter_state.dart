part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}
class FilterLoadedState extends FilterState {
  // final FilterResponse? data;
  const FilterLoadedState(
    // {
    // this.data,
  // }
  );
}
class FilterLoadErrorState extends FilterState {}
class FilterDataLoadedState extends FilterState {
  // final List<ProductDetailsModel>? data;
   const FilterDataLoadedState(
    // {this.data}
    );
}
class FilterDataLoadErrorState extends FilterState {}
class FilterDataLoadingState extends FilterState {}
class SelectRateState extends FilterState {}

class GetBrandsLoading extends FilterState {}

class GetBrandsSuccess extends FilterState {}

class GetBrandsError extends FilterState {}