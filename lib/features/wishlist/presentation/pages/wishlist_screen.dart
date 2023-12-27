import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/ShimmerWidget.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/no_result_widget.dart';
import 'package:lechoix/core/widgets/product_widget/product_widget.dart';
import 'package:lechoix/core/widgets/product_widget/shimmer/product_grid_shimmer_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/features/product/presentation/pages/product_screen.dart';
import 'package:lechoix/features/wishlist/presentation/cubit/wishlist_bloc.dart';
import '../../../../core/base/base_state.dart';
import '../../../../data/model/ProductModel.dart';

class WishlistScreen extends StatefulWidget {
  static GlobalKey<_WishlistScreenState> wishlistStateKey = GlobalKey();

  const WishlistScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends BaseState<WishlistScreen, WishlistBloc>
    with WidgetsBindingObserver {
  @override
  void initBloc() {
    bloc = WishlistBloc(this);
  }

  void refresh() {
    bloc.getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(centerWidget: Text(localize("Wishlist"))),
        body: StreamWidget<List<ProductModel>?>(
          stream: bloc.productsController.stream,
          onRetry: bloc.getWishlist,
          loadingWidget: const ShimmerWidget(
            child: ProductGridShimmerWidget(),
          ),
          child: (dataList) {
            var list = dataList ?? [];
            return list.isEmpty
                ? const Center(
                    child: NoResultWidget(),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        product: list[index],
                        onClick: () async {
                          await navigateTo(
                            ProductScreen(
                              productId: list[index].id ?? 0,
                            ),
                            myContext: NavigationUtil
                                .wishlistNavigatorKey.currentContext,
                          );
                          refresh();
                        },
                        onFavorite: () {
                          bloc.removeFromFavorites(list[index]);
                        },
                      );
                    },
                  );
          },
        ));
  }
}
