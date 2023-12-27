// import 'dart:convert';
// import 'dart:developer';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/error/exceptions.dart';
// import '../../../../core/error/failures.dart';
// import '../../../../core/local/auth_local_datasource.dart';
// import '../../../../core/usecases/usecases.dart';
// import '../../../../core/util/new_navigator/navigator.dart';
// import '../../../../core/widgets/toast.dart';
// import '../../../../injection_container/injection_container.dart';
// import '../../../auth/domain/usecase/login_usecase.dart';
// import '../../data/models/my_order_model.dart';
// import '../../data/models/order_details.dart';
// import '../../data/models/payment_methods_model.dart';
// import '../../domain/usecases/cancel_order.dart';
// import '../../domain/usecases/check_coupon.dart';
// import '../../domain/usecases/get_cach_methods.dart';
// import '../../domain/usecases/get_myOrders.dart';
// import '../../domain/usecases/order.dart';
// import '../../domain/usecases/order_visitor.dart';
// import '../../domain/usecases/show_order.dart';

// part 'orders_state.dart';

// class OrdersCubit extends Cubit<OrdersState> {
//   OrdersCubit({
//     required this.cancelOrder,
//     required this.checkCoupon,
//     required this.getMyOrders,
//     required this.orderProduct,
//     required this.showOrderDetails,
//     required this.getPaymentMethod,
//     required this.visitorOrder,
//   }) : super(OrdersInitial());
//   CancelOrder cancelOrder;
//   CheckCoupon checkCoupon;
//   GetMyOrders getMyOrders;
//   OrderProduct orderProduct;
//   VisitorOrderProduct visitorOrder;
//   GetPaymentMethod getPaymentMethod;
//   ShowOrderDetails showOrderDetails;

//   List<MyOrderData> myOrders = [];
//   int? selectedIndex = 1;
//   int? paymentWayIndex = 1;
//   List<MethodData> paymentMethods = [];
//   int? couponId;
//   double? couponDiscount;
//   double? totalScore;
//   int? discount;
//   TextEditingController couponController = TextEditingController();
//   final box = Hive.box("myBox");
//   OrderDetailsResponse? order;
//   bool applyCode = true;
//   bool? loginUser;

//   fGetOrderDetails(id) async {
//     emit(GetMyOrderDetailsLoading());
//     final failOrsuccess = await showOrderDetails(OrderDetailsParams(id: id));
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//       }
//     }, (success) async {
//       order = success;
//       emit(GetMyOrderDetailsSuccess(order: order!));
//     });
//   }

//   bool isUser() {
//     final userShared = sharedPreferences.getString(cacheTokenConst);
//     if (userShared != null) {
//       loginUser = true;
//       return true;
//     } else {
//       loginUser = false;
//       return false;
//     }
//   }

//   fGetMyOrders() async {
//     emit(GetMyOrdersLoading());
//     final failOrsuccess = await getMyOrders(NoParams());
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//       }
//       emit(GetMyOrdersError());
//     }, (success) async {
//       myOrders = success.orders!;
//       if (myOrders.isNotEmpty) {
//         emit(GetMyOrdersSuccess());
//       } else {
//         emit(GetMyOrdersEmpty());
//       }
//     });
//   }

//   Future<void> fGetPaymentMethod() async {
//     // emit(LatestProductsLoading());
//     final failOrsuccess = await getPaymentMethod(NoParams());
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//       }
//       // emit(LatestProductsError());
//     }, (success) async {
//       paymentMethods = success.data!;
//       //   emit(LatestProductsSuccess());
//     });
//   }

//   fCancelOrder(context, id) async {
//     emit(GetMyOrderDetailsLoading());
//     final failOrsuccess = await cancelOrder(CancelOrderParams(id: id));
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//       }
//       // emit(LatestProductsError());
//     }, (success) {
//       emit(CancelOrderSuccesss());
//       Navigation.pop(context);
//       Navigation.pop(context);
//       Navigation.pushReplacement(context, screen: const OrdersScreen());
//       showToast(success);
//       // myOrders = success.data!;
//     });
//   }

//   fCheckCoupon(context,
//       {required double total, int? shipping, int? tax}) async {
//     emit(ChechCouponLoading());
//     final failOrsuccess =
//         await checkCoupon(CheckCouponParams(code: couponController.text));
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//         couponDiscount = 0.0;
//         log(couponDiscount.toString());
//         couponDiscount = sumDiscount(total: total, amount: (discount ?? 0));
//         sumLastTotal(total: total, shipping: shipping, tax: tax);
//         showToast(tr("invalid_coupon"));
//         emit(const ChechCouponError(0));
//       }
//     }, (success) async {
//       discount = int.tryParse(success.data!.amount!);
//       couponId = success.data!.id;
//       couponDiscount = sumDiscount(total: total, amount: (discount ?? 0));
//       sumLastTotal(total: total, shipping: shipping, tax: tax);
//       applyCode = false;
//       FocusScope.of(context).nextFocus(); // showToast(tr("invalid_coupon" , ));
//       emit(ChechCouponSuccess(discount!));
//     });
//   }

//   cancelCoupon() {
//     couponController.clear();
//     applyCode = true;
//     emit(ClearCoupon());
//   }

//   double sumDiscount({
//     required double total,
//     int? amount,
//   }) {
//     return total * ((amount ?? 0) / 100);
//   }

//   double sumLastTotal({
//     required double total,
//     int? shipping,
//     int? tax,
//     int? amount,
//   }) {
//     totalScore = total +
//         // (tax ?? 0) +
//         (shipping ?? 0) -
//         sumDiscount(total: total, amount: amount);
//     couponDiscount = sumDiscount(total: total, amount: (amount ?? 0));
//     box.put("totalScores", totalScore);
//     return totalScore ?? 0;
//   }

//   fOrderProduct(context,
//       {int? addressId, String? payMethod, int? shippingCost}) async {
//     emit(OrderProductLoading());
//     if (addressId != 0 || addressId != null) {
//       final failOrsuccess = await orderProduct(OrderProductParams(
//         addressId: addressId!,
//         couponId: couponId,
//         discount: discount,
//         method: payMethod,
//         shippingCost: shippingCost,
//         prices: json.decode(box.get("prices")).cast<int>() ?? [],
//         productId: json.decode(box.get("options")).cast<int>() ?? [],
//         quantits: json.decode(box.get("quantitys")).cast<int>() ?? [],
//         total: box.get("totalScores"),
//       ));
//       failOrsuccess.fold((fail) {
//         if (fail is ServerFailure) {
//           fail.message;
//           showToast(fail.message);
//           emit(OrderProductError());
//         }
//       }, (success) async {
//         showToast(tr("order_success"));
//         box.put("options", jsonEncode([]));
//         Navigation.popAllAndPush(context, screen: HomeLayoutScreen());
//         emit(OrderProductSuccess());
//       });
//     } else {
//       showToast("please, select address to continue");
//     }
//   }

//   fVisitorOrderProduct(
//     context, {
//     required String payMethod,
//     required String firstName,
//     required String lastName,
//     required String phone,
//     required String address,
//     required int cityId,
//     required String password,
//   }) async {
//     emit(OrderProductLoading());
//     if (address.isNotEmpty) {
//       final failOrsuccess = await visitorOrder(VisitorOrderProductParams(
//         firstName: firstName,
//         lastName: lastName,
//         phone: phone,
//         password: password,
//         address: address,
//         cityId: cityId.toString(),
//         couponId: couponId,
//         discount: discount,
//         method: payMethod,
//         prices: json.decode(box.get("prices")).cast<int>() ?? [],
//         productId: json.decode(box.get("options")).cast<int>() ?? [],
//         quantits: json.decode(box.get("quantitys")).cast<int>() ?? [],
//         total: box.get("totalScores"),
//       ));
//       failOrsuccess.fold((fail) {
//         if (fail is ServerFailure) {
//           fail.message;
//           showToast(fail.message);
//           emit(OrderProductError());
//         }
//       }, (success) async {
//         showToast(tr("order_success"));
//         box.put("options", jsonEncode([]));
//         Map<String, dynamic> userLoginInfo =
//             LoginParams(userPassword: password, userPhone: phone).toMap();
//         try {
//           await sharedPreferences.setString(
//               loginInfoConst, json.encode(userLoginInfo));
//         } catch (e) {
//           throw CacheException();
//         }
//         // await sharedPreferences.setString(
//         //     loginInfoConst, json.encode(userLoginInfo));
//         emit(VisitorOrderSuccess());
//       });
//     } else {
//       showToast("please, select address to continue");
//     }
//   }
// }
