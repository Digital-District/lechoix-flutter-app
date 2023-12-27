import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/brands_model.dart';
import '../../domain/usecases/get_brans.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit({required this.getbrands}) : super(FilterInitial());
  static FilterCubit get(BuildContext context) => BlocProvider.of(context);
  final GetBrands getbrands;

  List<Brand>? brands = [];
  bool? selectedCategory = false;
  int? brandId;
  int? categoryId;
  int? sizeId;
  int? colorId;
  String? discount;
  bool selectDiscount = false;
  bool selectColor = false;
  bool selectSize = false;
  String? ratingStar;
  Map<String, dynamic> filterSelected = {};
  // ignore: prefer_typing_uninitialized_variables
  var selectedRate;

  fGetBrands() async {
    emit(GetBrandsLoading());
    final failOrsuccess = await getbrands(NoParams());
    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      emit(GetBrandsError());
    }, (success) async {
      emit(GetBrandsSuccess());
      brands = success.brands!;
    });
  }
}
