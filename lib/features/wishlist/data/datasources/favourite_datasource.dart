import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../../product/data/models/products_response.dart';

const addFavoApi = "update-favorite";
const myFavouritesApi = "my-favourite";

abstract class FavouritesRemoteDataSource {
  Future<ProductsResponseNoPagination> getMyFavourites();
  Future<bool> addToFavourites({required int productId});
}

class FavouritesRemoteDataSourceImpl implements FavouritesRemoteDataSource {
  final ApiBaseHelper helper;

  FavouritesRemoteDataSourceImpl({
    required this.helper,
  });

  @override
  Future<bool> addToFavourites({required int productId}) async {
    try {
      final response =
          await helper.post(url: addFavoApi, body: {"product_id": productId});
      return response["favourite"];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ProductsResponseNoPagination> getMyFavourites() async {
    try {
      final response = await helper.get(
        url: myFavouritesApi,
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
}
