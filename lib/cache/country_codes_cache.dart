import 'package:collection/collection.dart';
import 'package:lechoix/data/model/CountryCodeModel.dart';

class CountryCodesCache {
  static final CountryCodesCache _instance = CountryCodesCache._private();

  static CountryCodesCache get instance => _instance;

  CountryCodesCache._private();

  final List<CountryCodeModel> _countryCodes = [];

  set countryCodes(List<CountryCodeModel> list) {
    _countryCodes.clear();
    _countryCodes.addAll(list);
  }

  List<CountryCodeModel> get countryCodes => _countryCodes;

  CountryCodeModel? get firstOrNull => _countryCodes.firstOrNull;
}
