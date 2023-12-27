import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/lazy_load_indexed_stack.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/features/account/presentation/pages/more_screen.dart';
import 'package:lechoix/features/cart/presentation/pages/cart_screen.dart';
import 'package:lechoix/features/categories/presentation/pages/categories_screen.dart';
import 'package:lechoix/features/home/presentation/pages/gender_select_screen.dart';
import 'package:lechoix/features/host/host_bloc.dart';
import 'package:lechoix/features/wishlist/presentation/pages/wishlist_screen.dart';

import '../../core/base/base_state.dart';

class HostScreen extends StatefulWidget {
  static final hostPageKey = GlobalKey<_HostScreenState>();

  const HostScreen({super.key});

  @override
  State<HostScreen> createState() => _HostScreenState();
}

class _HostScreenState extends BaseState<HostScreen, HostBloc> {
  HostNavItem homeItem = HostNavItem(
    Navigator(
      key: NavigationUtil.homeNavigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => const GenderSelectionScreen(),
      ),
    ),
    NavigationUtil.homeNavigatorKey,
  );

  HostNavItem categoriesItem = HostNavItem(
    Navigator(
      key: NavigationUtil.categoriesNavigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => const CategoriesScreen(),
      ),
    ),
    NavigationUtil.categoriesNavigatorKey,
  );

  HostNavItem wishlistItem = HostNavItem(
    Navigator(
      key: NavigationUtil.wishlistNavigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) =>
            WishlistScreen(key: WishlistScreen.wishlistStateKey),
      ),
    ),
    NavigationUtil.wishlistNavigatorKey,
  );

  HostNavItem bagItem = HostNavItem(
    Navigator(
      key: NavigationUtil.bagNavigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => CartScreen(
          key: CartScreen.cartStateKey,
        ),
      ),
    ),
    NavigationUtil.bagNavigatorKey,
  );

  HostNavItem moreItem = HostNavItem(
    Navigator(
      key: NavigationUtil.moreNavigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => const MoreScreen(),
      ),
    ),
    NavigationUtil.moreNavigatorKey,
  );

  List<HostNavItem> getNavItems() {
    var list = [
      homeItem,
      categoriesItem,
      wishlistItem,
      bagItem,
      moreItem,
    ];

    return list;
  }

  late final List<HostNavItem> navItems = [
    homeItem,
    categoriesItem,
    wishlistItem,
    bagItem,
    moreItem,
  ];

  int _currentIndex = 0;

  @override
  void initBloc() {
    bloc = HostBloc(this);
    HostBloc.updateCartCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: UIConstants.secondaryColor,
          unselectedItemColor: UIConstants.gray1Color,
          selectedLabelStyle: TextStyleConstants.bodyMedium,
          onTap: _selectIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: localize("Home"),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.checkroom_sharp),
              label: localize("Categories"),
            ),
            BottomNavigationBarItem(
              icon:
                  // const Icon(Icons.favorite_border),
                  Image.asset(
                "assets/images/cart_heart_icon.png",
                height: 25,
                color: _currentIndex == 2
                    ? UIConstants.secondaryColor
                    : UIConstants.blackColor,
              ),
              label: localize("Wishlist"),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  // const Icon(Icons.shopping_bag_outlined),
                  Image.asset(
                    "assets/images/bag_icon.png",
                    height: 25,
                    color: _currentIndex == 3
                        ? UIConstants.secondaryColor
                        : UIConstants.blackColor,
                  ),
                  Positioned(
                    right: 0,
                    child: StreamWidget(
                      stream: HostBloc.cartCountController,
                      loadingWidget: Container(),
                      onRetry: HostBloc.updateCartCount,
                      child: (count) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: UIConstants.secondaryColor,
                              shape: BoxShape.circle),
                          child: Text(
                            '$count',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              label: localize("Bag"),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.more_horiz_outlined),
              label: localize("More"),
            ),
          ]),
      body: Center(
        child: WillPopScope(
          onWillPop: () async => !await navItems
              .map((e) => e.key)
              .toList()[_currentIndex]
              .currentState!
              .maybePop(),
          child: LazyLoadIndexedStack(
            index: _currentIndex,
            children: navItems.map((e) => e.screen).toList(),
          ),
        ),
      ),
    );
  }

  void _selectIndex(int index) {
    if (index == navItems.indexOf(wishlistItem)) {
      WishlistScreen.wishlistStateKey.currentState?.refresh();
    }
    if (index == navItems.indexOf(bagItem)) {
      CartScreen.cartStateKey.currentState?.refresh();
    }
    if (index == _currentIndex) {
      setState(() {
        navItems
            .map((e) => e.key)
            .toList()[_currentIndex]
            .currentState
            ?.popUntil((route) => route.isFirst);
      });
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void navigateToHome() {
    setState(() {
      _currentIndex = 0;
    });
  }
}

class HostNavItem {
  final Widget screen;
  final GlobalKey<NavigatorState> key;

  HostNavItem(this.screen, this.key);
}
