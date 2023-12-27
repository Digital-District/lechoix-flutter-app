import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/slider_model.dart';
import '../../../domain/useCases/get_slides.dart';
import '../../../../product/data/models/products_response.dart';
import '../../../../product/domain/usecases/get_products.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/entities/cities.dart';
import '../../../domain/useCases/get_cities.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getCities,
    required this.getProducts,
    required this.getSlides,
  }) : super(HomeInitial());

  final GetCities getCities;
  final GetSlides getSlides;
  final GetProducts getProducts;
  List<City> cities = [
    City(name: "لا يوجد", countryId: 0, id: 0, shippingCost: 0)
  ];
  City? _selectCity;
  City? get slelectCity => _selectCity;
  int? cityId;

  List<Product>? products = [];
  List<SliderImage>? slides = [];
  //choose City
  chooseCity(
    City cityModel,
  ) async {
    _selectCity = cityModel;
    cityId = _selectCity!.countryId;
    emit(HomeInitial());
    emit(GetCitiesSuccess());
  }

  fGetCities() async {
    final failOrsuccess = await getCities(NoParams());

    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
    }, (success) async {
     cities= LinkedHashSet<City>.from(success.cities!).toList();
      if (cities.length == 1) {
        // _selectCountry = countries.first;
        // countryId = _selectCountry!.countryId;
        // fGetStates(_selectCountry!.countryId);
      }
    });
  }

  fGetHomeSlides() async {
    emit(GetSlidesLoading());
    final failOrsuccess = await getSlides(NoParams());

    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      emit(GetSlidesError());
    }, (success) async {
      slides = success.data!;
      emit(GetSlidesSuccess());

      if (cities.length == 1) {
        // _selectCountry = countries.first;
        // countryId = _selectCountry!.countryId;
        // fGetStates(_selectCountry!.countryId);
      }
    });
  }

  fGetProducts(id) async {
    final failOrsuccess = await getProducts(GetProductParams(id: id));

    failOrsuccess.fold((fail) {
      if (fail is ServerFailure) {
        fail.message;
      }
      // emit(GetRegisterParametersErrorState());
    }, (success) async {
      products = success.data!.data!;
      if (products!.length == 1) {
        // _selectCountry = countries.first;
        // countryId = _selectCountry!.countryId;
        // fGetStates(_selectCountry!.countryId);
      }
    });
  }
}
