import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/usecases/get_cart.dart';
import '../models/cart_response.dart';

const cartApi = "cart-products";

abstract class CartRemoteDataSource {
  Future<CartResponse> getCart({required CartParams params});
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiBaseHelper helper;

  CartRemoteDataSourceImpl({
    required this.helper,
  });

  //get Cart
  @override
  Future<CartResponse> getCart({required CartParams params}) async {
    try {
      final response = await helper
          .post(url: cartApi, body: {"products": "${params.productIds}"});
      if (response["success"] == "true") {
        debugPrint("get Cart done${params.productIds} ");
        log(response.toString());
        return CartResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      debugPrint("Server exception${e.message}");
      throw ServerException(message: e.message);
    }
  }
}
