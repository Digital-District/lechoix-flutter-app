import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/usecases/order.dart';
import '../../domain/usecases/order_visitor.dart';
import '../datasources/order_local_datasource.dart';
import '../datasources/order_remote_datasource.dart';
import '../models/coupon_model.dart';
import '../models/my_order_model.dart';
import '../models/order_details.dart';
import '../models/order_model.dart';
import '../models/payment_methods_model.dart';
import '../models/visitor_order_model.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource remote;
  final OrderLocalDataSource local;

  OrdersRepositoryImpl({
    required this.remote,
    required this.local,
  });
  @override
  Future<Either<Failure, MyOrdersResponse>> getMyOrders() async {
    try {
      final response = await remote.getMyOrders();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails({required int id}) async {
    try {
      final response = await remote.getOrderDetails(id: id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> cancelOrder({required int id}) async {
    try {
      final response = await remote.cancelOrder(id: id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } 
  }


  @override
  Future<Either<Failure, CouponResponse>> checkCoupon({required String code}) async {
    try {
      final response = await remote.checkCoupon(code: code);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }



  @override
  Future<Either<Failure, OrderResponse>> order(
      {required OrderProductParams params}) async {
    try {
      final response = await remote.order(params: params);
      // final response = await remote.order(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
    }
  
  @override
  Future<Either<Failure, PaymentMethodResponse>> getPaymentMethod() async{
   try {
      final response = await remote.getPaymentMethod();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, VisitorOrderResponse>> visitorOrder({required VisitorOrderProductParams params}) async{
  try {
      final response = await remote.visitorOrder(params: params);
      // final response = await remote.order(params: params);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
