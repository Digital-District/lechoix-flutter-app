import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../core/error/failures.dart';
import '../../../data/models/cart_response.dart';
import '../../../domain/usecases/get_cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.getCart}) : super(CartInitial());
  final GetCart getCart;
  List<int> productIds = [];
  List<int> quantitys = [];
  List<int> prices = [];
  List<int> options = [];
  double _totalScores = 0.0;

  double get totalScores => _totalScores;

  set totalScores(double value) {
    _totalScores = value;
  }

  List<String> productName = [];
  List<String> productImages = [];
  int total = 0;

  final box = Hive.box("myBox");
  CartResponse? cartData;
  bool noQuantity = false;

  void clear() {
    productIds.clear();
    quantitys.clear();
    prices.clear();
    productName.clear();
    productImages.clear();
    options.clear();
    _totalScores = 0.0;
  }

  Future<void> fGetCartData() async {
    emit(GetCartDataLoading());
    if (box.isEmpty) {
      box.put("options", jsonEncode([]));
    }
    if (box.isNotEmpty) {
      clear();
      options = json.decode(box.get("options")).cast<int>() ?? [];
      log(options.toString());
      final failOrsuccess = await getCart(CartParams(productIds: options));
      failOrsuccess.fold((fail) {
        if (fail is ServerFailure) {
          fail.message;
          emit(GetCartDataError());
        }
      }, (success) async {
        cartData = success;
        if (cartData!.data!.isNotEmpty) {
          clear();
          for (int x = 0; x < cartData!.data!.length; x++) {
            final data = cartData!.data![x];
            options.add(data.id!);
            productIds.add(data.product!.id!);
            quantitys
                .add(data.quantity != null ? int.parse(data.quantity!) : 0);
            prices.add(int.parse("${data.salePrice ?? data.price!}"));
            productName.add(data.product!.title!);
            productImages.add(data.product!.image!);
          }
          sumPrices();
          emit(GetCartDataSuccess(_totalScores));
          box.put("productIds", jsonEncode(productIds));
          box.put("options", jsonEncode(options));
          box.put("quantitys", jsonEncode(quantitys));
          box.put("prices", jsonEncode(prices));
          box.put("totalScores", _totalScores);
          box.put("productName", jsonEncode(productName));
          box.put("productImages", jsonEncode(productImages));
          emit(GetCartDataSuccess(_totalScores));
        }
        emit(GetCartDataSuccess(_totalScores));
      });
    } else {
      emit(GetCartDataFailed());
    }
  }

  sumPrices() {
    _totalScores = prices.fold(0,
        (previousValue, element) => previousValue + double.parse("$element"));
    log("prices$prices");
    emit(GetCartDataSuccess(totalScores));
  }

  void updateCart({
    required int index,
    required int newQuantity,
  }) {
    quantitys[index] = newQuantity;
    prices[index] = int.parse(
            "${cartData!.data![index].salePrice ?? cartData!.data![index].price!}") *
        quantitys[index];
    sumPrices();
    if (box.isOpen) {
      box.put("productIds", jsonEncode(productIds));
      box.put("quantitys", jsonEncode(quantitys));
      box.put("prices", jsonEncode(prices));
      box.put("totalScores", _totalScores);
      box.put("options", jsonEncode(options));
      box.put("productName", jsonEncode(productName));
      box.put("productImages", jsonEncode(productImages));
    } else {}
  }

  deleteFromCart({required int? index}) {
    log(options.toString());
    log(productIds.toString());
    options.removeAt(index!);
    productIds.removeAt(index);
    quantitys.removeAt(index);
    prices.removeAt(index);
    productName.removeAt(index);
    productImages.removeAt(index);
    sumPrices();
    box.put("options", jsonEncode(options));
    box.put("productIds", jsonEncode(productIds));
    box.put("quantitys", jsonEncode(quantitys));
    box.put("prices", jsonEncode(prices));
    box.put("totalScores", _totalScores);
    box.put("productName", jsonEncode(productName));
    box.put("productImages", jsonEncode(productImages));
    if (productIds.isEmpty) {
      clear();
    }
    fGetCartData();
  }
}
