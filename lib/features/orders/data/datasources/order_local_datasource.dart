import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/usecases/order.dart';

const cartCacheConst = "cart_cache";
const cacheTokenConst = "cache_token";
const getCachedOrderConst = "cart_info";

abstract class OrderLocalDataSource {
  Future<void> cacheCartDataToOrder({required OrderProductParams order});
  Future<OrderProductParams> getCachedCartData();
  Future<void> clearCartData();

  Future<bool> isUser();
//   Future<void> cacheUserAccessToken({required String token});
//   Future<String> getCacheUserAccessToken();
//   Future<String> checkAccessForGuest();
//   Future<void> cacheUserLoginInfo({required LoginParams params});
//   Future<LoginParams> getCacheUserLoginInfo();
}

class OrderLocalDataSourceImpl extends OrderLocalDataSource {
  final SharedPreferences sharedPreference;
  final box = Hive.box("myBox");

  OrderLocalDataSourceImpl({required this.sharedPreference});

  // @override
  // Future<void> cacheCartDataToOrder({required OrderProductParams order}) async {
  //   try {
  //     await sharedPreference.setString(cartCacheConst, order.toString());
  //     debugPrint(cacheTokenConst);
  //   } catch (e) {
  //     throw CacheException();
  //   }
  // }

  // @override
  // Future<OrderProductParams> getCachedCartData() async {
  //   try {
  //     final userShared = sharedPreference.getString(cartCacheConst);
  //     debugPrint(userShared);
  //     if (userShared != null) {
  //       final json = jsonDecode(userShared);
  //       return OrderProductParams.fromJson(json);
  //     } else {
  //       throw NoCachedUserException();
  //     }
  //   } on NoCachedUserException {
  //     throw NoCachedUserException();
  //   } catch (e) {
  //     throw CacheException();
  //   }
  // }

  @override
  Future<OrderProductParams> getCachedCartData() async {
    try {
      // final cartData = sharedPreference.getString(cartCacheConst);
      json.decode(box.get("options"));
      json.decode(box.get("productIds"));
      json.decode(box.get("quantitys"));
      box.get("totalScores");

      if (box.isNotEmpty) {
        return OrderProductParams(
            prices: json.decode(box.get("prices")),
            productId: json.decode(box.get("options")),
            quantits: json.decode(box.get("quantitys")),
            total: box.get("totalScores"));
      } else {
        throw NoCachedCartException();
      }
    } catch (e) {
      throw NoCachedUserException();
    }
  }

  @override
  Future<void> clearCartData() async {
    try {
      await sharedPreference.remove(cartCacheConst);
    } catch (e) {
      throw NoCachedUserException();
    }
  }

  @override
  Future<void> cacheCartDataToOrder({required OrderProductParams order}) async {
    try {
      await sharedPreference.setString(
          cartCacheConst, json.encode(order.toMap()));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isUser() async {
    try {
      final userShared = sharedPreference.getString(cacheTokenConst);
      if (userShared != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
