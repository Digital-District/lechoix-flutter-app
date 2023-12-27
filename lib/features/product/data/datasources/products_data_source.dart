import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/usecases/get_latest_products.dart';
import '../models/product_details.dart';
import '../models/products_response.dart';

const productsApi = "products/";
const productDetailsApi = "product/";
const latestProductApi = "latest/";
const mostSellerProductApi = "more-seller/";
const mostRatedProductApi = "more-ratings/";

abstract class ProductsRemoteDataSource {
  Future<ProductsResponse> getProducts({required int id});
  Future<ProductDetailsResponse> getProductDetails({required int id}); 
   Future<ProductsResponse> getLatestProducts( HomeListsParams params);
   Future<ProductsResponse> getMostSellerProducts(HomeListsParams params);
   Future<ProductsResponseNoPagination> getMostRatedProducts();
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ApiBaseHelper helper;

  ProductsRemoteDataSourceImpl({
    required this.helper,
  });

  //get products
  @override
  Future<ProductsResponse> getProducts({required int id}) async {
    try {
      final response = await helper.get(
        url: productsApi,
      );
      if (response["success"] == "true") {
        return ProductsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ProductDetailsResponse> getProductDetails({required int id}) async {
    try {
      final response = await helper.get(
        url: "$productDetailsApi$id",
      );
      if (response["success"] == "true") {
        return ProductDetailsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  
  @override
  Future<ProductsResponse> getLatestProducts( HomeListsParams params) async{
    try {
      final response = await helper.get(
        url:"$latestProductApi?page=${params.page}",
      );
      if (response["success"] == "true") {
        return ProductsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  
  @override
  Future<ProductsResponseNoPagination> getMostRatedProducts() async{
  try {
      final response = await helper.get(
        url:mostRatedProductApi,
      );
      if (response["success"] == "true") {
        return ProductsResponseNoPagination.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
  
  @override
  Future<ProductsResponse> getMostSellerProducts(HomeListsParams params) async{
 try {
      final response = await helper.get(
        url:"$mostSellerProductApi?page=${params.page}",
      );
      if (response["success"] == "true") {
        return ProductsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

}
