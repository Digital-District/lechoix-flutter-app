import 'package:lechoix/base/base_bloc.dart';
import 'package:lechoix/base/base_view.dart';
import 'package:lechoix/cache/configuration_cache.dart';
import 'package:lechoix/cache/country_codes_cache.dart';
import 'package:lechoix/data/response/OnBoardingResponse.dart';
import 'package:lechoix/repo/ConfigRepo.dart';

class SplashBloc extends BaseBloc {
  ConfigRepo _repo = ConfigRepo();

  SplashBloc(BaseView view) : super(view);

  Future<void> getCountryCodes() async {
    try {
      var baseResponse = await _repo.getCountryCodes();
      CountryCodesCache.instance.countryCodes =
          baseResponse.data?.countryCodes ?? [];
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> getConfigurations() async {
    try {
      var baseResponse = await _repo.getConfigurations();
      ConfigurationCache.instance.countConfiguration = baseResponse.data;
    } catch (e) {
      handleError(e);
    }
  }


  Future<OnBoardingResponse?> getOnBoardingScreens() async {
    view.showProgress();
    try {
      var baseResponse = await _repo.getOnBoardingScreens();
      view.hideProgress();
      return baseResponse.data;
    } catch (e) {
      handleError(e);
    }
    return null;
  }


  @override
  void onDispose() {
    _repo.dispose();
  }
}
