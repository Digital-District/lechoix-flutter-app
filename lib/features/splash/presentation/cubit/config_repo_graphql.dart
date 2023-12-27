import '../../../../core/base/base_repo.dart';
import '../../../../core/util/network/endpoints.dart';
import '../../../../data/ConfigurationModel.dart';
import '../../../../data/Enumeration.dart';
import '../../../../data/address/locations/LocationsResponse.dart';
import '../../../../data/base/BaseResponse.dart';
import '../../../../data/response/CountryCodeResponse.dart';
import '../../../../data/response/OnBoardingResponse.dart';

class ConfigRepoGql extends BaseRepo {
  Future<BaseResponse<CountryCodeResponse>> getCountryCodes() {
    const query = """
query Countries {
    countries {
        full_name_english
        full_name_locale
        id
        three_letter_abbreviation
    }
}
""";
    return graphQLService.performQuery(query, variables: {});
    // networkManager.request<CountryCodeResponse>(
    //   Endpoints.getCountryCodes,
    //   Method.GET,
    // );
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
