import '../../../data/CategoryModel.dart';
import '../../../data/ConfigurationModel.dart';
import '../../../data/address/AddressResponse.dart';
import '../../../data/address/locations/LocationsResponse.dart';
import '../../../data/cart/CartResponse.dart';
import '../../../data/filtration/Response/FiltrationDataList.dart';
import '../../../data/home/HomeResponse.dart';
import '../../../data/model/HTMLModel.dart';
import '../../../data/model/ProductModel.dart';
import '../../../data/orders/MyOrdersResponse.dart';
import '../../../data/orders/OrderModel.dart';
import '../../../data/response/CountryCodeResponse.dart';
import '../../../data/response/OnBoardingResponse.dart';
import '../../../data/response/ProductsResponse.dart';
import '../../../features/auth/domain/entities/auth/AuthResponseModel.dart';



class Parser {
  static parse<T>(Map<String, dynamic> json) {
    switch (T) {
      case const (CategoryResponse):
        return CategoryResponse.fromJson(json);
      case const (AuthResponseModel):
        return AuthResponseModel.fromJson(json);
      case const (CountryCodeResponse):
        return CountryCodeResponse.fromJson(json);
      case const (HtmlModel):
        return HtmlModel.fromJson(json);
      case const (ProductsResponse):
        return ProductsResponse.fromJson(json);
      case const (ProductModel):
        return ProductModel.fromJson(json);
      case const (CartResponse):
        return CartResponse.fromJson(json);
      case const (AddressResponse):
        return AddressResponse.fromJson(json);
      case const (FiltrationDataList):
        return FiltrationDataList.fromJson(json);
      case const (OrderModel):
        return OrderModel.fromJson(json);
      case const (LocationsResponse):
        return LocationsResponse.fromJson(json);
      case const (MyOrdersResponse):
        return MyOrdersResponse.fromJson(json);
      case const (ConfigurationModel):
        return ConfigurationModel.fromJson(json);
      case const (HomeResponse):
        return HomeResponse.fromJson(json);
      case const (OnBoardingResponse):
        return OnBoardingResponse.fromJson(json);

      default:
        return json;
    }
  }
}
