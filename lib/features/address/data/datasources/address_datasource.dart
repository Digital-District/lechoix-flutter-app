import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/usecases/add_address.dart';
import '../models/add_address_model.dart';
import '../models/myAddress_model.dart';

const myAddressesApi = "my-addresses";
const editAddressApi = "edit-address/";
const deleteAddressApi = "delete-address/";
const addAddressApi = "store-address";

abstract class AddressRemoteDataSource {
  Future<MyAddressResponse> getMyAddresses();
  Future<Unit> editAddress({required int addressID});
  Future<String> deleteAddress({required int addressID});
  Future<AddAddressResponse> addAddress({required AddAddressParams params});
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final ApiBaseHelper helper;

  AddressRemoteDataSourceImpl({
    required this.helper,
  });

  @override
  Future<MyAddressResponse> getMyAddresses() async {
    try {
      final response = await helper.get(
        url: myAddressesApi,
      );
      if (response["success"] == "true") {
        return MyAddressResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<AddAddressResponse> addAddress(
      {required AddAddressParams params}) async {
    try {
      final response =
          await helper.post(url: addAddressApi, body: params.toMap());
      // return unit;
      if (response["success"] == "true") {
        log(response.toString());
        return AddAddressResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<Unit> editAddress({required int addressID}) async {
    try {
      final response = await helper.get(
        url: "$editAddressApi$addressID",
      );
      return unit;
      // if (response["success"] == "true") {
      //   return ProductsResponse.fromJson(response);
      // } else {
      //   throw ServerException(message: response['message']);
      // }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> deleteAddress({required int addressID}) async {
    try {
      final response = await helper.get(
        url: "$deleteAddressApi$addressID",
      );
      if (response["success"] == "true") {
        return response["message"];
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
