import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lechoix/features/address/address_inj.dart';
import 'package:lechoix/features/filter/filters_inj.dart';
import 'package:lechoix/features/offers/offers_inj.dart';
import 'package:lechoix/features/orders/orders_inj.dart';
import 'package:lechoix/features/product/product_inj.dart';
import '../core/util/api_basehelper.dart';
import '../features/auth/auth_inj.dart';
import '../features/categories/categories_inj.dart';
import '../features/home/home_inj.dart';

final sl = GetIt.instance;
final helper = ApiBaseHelper();
late final SharedPreferences sharedPreferences;

Future<void> init() async {
  await initAuthInjection(sl);
  await initHomeInjection(sl);
  await initCategoriesInjection(sl);
  await initFiltersInjection(sl);
  await initOffersInjection(sl);
  await initProductInjection(sl);
  await initOrdersInjection(sl);
  await initAddressInjection(sl);

//hive init
  // var systemTempDir = Directory.systemTemp;
  // await Hive.initFlutter(systemTempDir.path);
  // await Hive.openBox('myBox');

  sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  helper.dioInit();
  sl.registerLazySingleton(() => helper);
}
