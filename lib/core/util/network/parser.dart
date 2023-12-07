import 'package:lechoix/data/CategoryModel.dart';
import 'package:lechoix/data/ConfigurationModel.dart';
import 'package:lechoix/data/address/AddressResponse.dart';
import 'package:lechoix/data/address/locations/LocationsResponse.dart';
import 'package:lechoix/data/cart/CartResponse.dart';
import 'package:lechoix/data/filtration/Response/FiltrationDataList.dart';
import 'package:lechoix/data/home/HomeResponse.dart';
import 'package:lechoix/data/model/HTMLModel.dart';
import 'package:lechoix/data/model/ProductModel.dart';
import 'package:lechoix/data/orders/MyOrdersResponse.dart';
import 'package:lechoix/data/orders/OrderModel.dart';
import 'package:lechoix/data/response/CountryCodeResponse.dart';
import 'package:lechoix/data/response/OnBoardingResponse.dart';
import 'package:lechoix/data/response/ProductsResponse.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthResponseModel.dart';



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
