import '../../data/ConfigurationModel.dart';

class ConfigurationCache {
  static final ConfigurationCache _instance = ConfigurationCache._private();

  static ConfigurationCache get instance => _instance;

  ConfigurationCache._private();

  ConfigurationModel? _configurationModel;

  set countConfiguration(ConfigurationModel? configurationModel) {
    _configurationModel = null;
    _configurationModel = configurationModel;
  }

  ConfigurationModel? get getData => _configurationModel;
}
