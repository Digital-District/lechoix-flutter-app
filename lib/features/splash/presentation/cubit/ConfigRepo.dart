import 'package:lechoix/base/base_repo.dart';
import 'package:lechoix/core/util/network/endpoints.dart';
import 'package:lechoix/data/ConfigurationModel.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/data/address/locations/LocationsResponse.dart';
import 'package:lechoix/data/base/BaseResponse.dart';
import 'package:lechoix/data/response/CountryCodeResponse.dart';
import 'package:lechoix/data/response/OnBoardingResponse.dart';
class ConfigRepo extends BaseRepo {
  Future<BaseResponse<CountryCodeResponse>> getCountryCodes() {
    return networkManager.request<CountryCodeResponse>(
      Endpoints.getCountryCodes,
      Method.GET,
    );
  }

  Future<BaseResponse<LocationsResponse>> getLocations() {
    return networkManager.request<LocationsResponse>(
      Endpoints.getLocations,
      Method.GET,
    );
  }

  Future<BaseResponse<ConfigurationModel>> getConfigurations() {
    return networkManager.request<ConfigurationModel>(
      Endpoints.configurations,
      Method.GET,
    );
  }

  Future<BaseResponse<OnBoardingResponse>> getOnBoardingScreens() {
    return networkManager.request<OnBoardingResponse>(
      Endpoints.onBoarding,
      Method.GET,
    );
  }
}
