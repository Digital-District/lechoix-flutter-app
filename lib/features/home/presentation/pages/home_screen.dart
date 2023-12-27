import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/ShimmerWidget.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/core/widgets/textField/text_field_widget.dart';
import 'package:lechoix/features/brandScreen/brand_screen.dart';
import 'package:lechoix/features/categories/presentation/pages/subcategory/subcategory_screen.dart';
import 'package:lechoix/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:lechoix/features/home/presentation/pages/brand_widget.dart';
import 'package:lechoix/features/home/presentation/pages/suggested_home_product_widget.dart';
import 'package:lechoix/features/product/presentation/pages/product_screen.dart';
import 'package:lechoix/features/search/search_screen.dart';

import '../../../../../data/CategoryModel.dart';
import '../../../../../data/home/HomeItemModel.dart';
import '../../../../../data/home/HomeResponse.dart';
import '../../../../../data/model/BrandModel.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/cache/configuration_cache.dart';
import '../../../../core/cache/user_cache.dart';
import '../../../../data/home/ActionModel.dart';
import 'home_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeBloc> {
  @override
  void initBloc() {
    bloc = HomeBloc(this);
    bloc.getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.logo(),
      body: Column(
        children: [
          Container(
            color: UIConstants.blackColor,
            height: 40,
            child: Center(
              child: Text(
                "${localize("Free Delivery all over Qatar above")} ${ConfigurationCache.instance.getData?.freeDeliveryAmount} ${ConfigurationCache.instance.getData?.currency}",
                style: TextStyleConstants.captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const VerticalSpace(12.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFieldWidget(
                      controller: TextEditingController(),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      readOnly: true,
                      hideBorder: true,
                      hint: "Search for products",
                      fillColor: UIConstants.gray6Color,
                      onClick: () {
                        navigateTo(SearchScreen(
                            categoryId: UserCache.instance.getCategoryId()));
                      },
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          "assets/images/ic_search.png",
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpace(12.0),
                  StreamWidget<HomeResponse?>(
                    stream: bloc.homeController.stream,
                    onRetry: bloc.getHomeData,
                    loadingWidget:
                        const ShimmerWidget(child: HomeShimmerWidget()),
                    child: (response) {
                      return Column(
                        children: [
                          getCarouselSliderWidget(response?.section1),
                          getSuggestedHomeProductWidget(response?.section2),
                          getBrandWidget(
                              response?.getFirstBrandSection() ?? []),
                          getSuggestedHomeProductWidget(response?.section4),
                          getBrandWidget(response?.getLastBrandSection() ?? []),
                          getSuggestedHomeProductWidget(response?.section5),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCarouselSliderWidget(List<HomeItemModel>? carouselDataList) {
    return carouselDataList == null
        ? Container()
        : CarouselSlider(
            items: carouselDataList.map((dataModel) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: BrandWidget(
                  brandModel: dataModel,
                  roundCorners: true,
                  onClick: () {
                    applyAction(dataModel.action);
                  },
                ),
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 0.90,
              enableInfiniteScroll: false,
              autoPlay: true,
              height: MediaQuery.of(context).size.width * 1.2,
            ),
          );
  }

  Widget getSuggestedHomeProductWidget(HomeItemModel? dataModel) {
    if (dataModel == null || dataModel.products == null) {
      return Container();
    }
    return SuggestedHomeProductWidget(
      dataModel: dataModel,
      onClick: () {
        applyAction(dataModel.action);
      },
    );
  }

  Widget getBrandWidget(List<HomeItemModel> dataList) {
    if (dataList.isEmpty == true) {
      return Container();
    }
    return Column(
      children: dataList
          .map((dataModel) => BrandWidget(
                brandModel: dataModel,
                onClick: () {
                  applyAction(dataModel.action);
                },
              ))
          .toList(),
    );
  }

  //TODO: TO BE Enhanced
  void applyAction(ActionModel? action) {
    print("${action?.type}  ${action?.id}");
    if (action != null) {
      if (action.type == "product") {
        navigateTo(ProductScreen(productId: action.id ?? 0),
            myContext: NavigationUtil.homeNavigatorKey.currentContext);
      } else if (action.type == "category") {
        navigateTo(
            SubcategoryScreen(
                subcategoryModel: action.category ?? CategoryModel()),
            myContext: NavigationUtil.homeNavigatorKey.currentContext);
      } else if (action.type == "brand") {
        navigateTo(
            BrandScreen(
              brandModel: action.brand ?? BrandModel(),
            ),
            myContext: NavigationUtil.homeNavigatorKey.currentContext);
      }
    }
  }
}
