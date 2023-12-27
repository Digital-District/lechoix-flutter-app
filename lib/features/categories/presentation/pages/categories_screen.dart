import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/card_widget.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/no_result_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:lechoix/features/categories/presentation/pages/subcategory/subcategory_screen.dart';

import '../../../../core/base/base_state.dart';
import '../../../../data/CategoryModel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState
    extends BaseState<CategoriesScreen, CategoriesBloc> {
  @override
  void initBloc() {
    bloc = CategoriesBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showDivider: false,
        centerWidget: Text(localize("Categories")),
        // actionIcon: IconButtonWidget(
        //   icon: Image.asset("assets/images/ic_search.png"),
        //   onClick: () {},
        // ),
      ),
      body: StreamWidget<List<CategoryModel>?>(
        stream: bloc.categoriesController.stream,
        onRetry: bloc.getCategories,
        child: (list) {
          var categories = list ?? [];
          return DefaultTabController(
            length: categories.length,
            child: Column(
              children: [
                CardWidget(
                  radius: 0.0,
                  elevation: 4.0,
                  shadowColor: const Color(0xff0d000000),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: UIConstants.goldColor,
                    labelColor: UIConstants.goldColor,
                    unselectedLabelColor: UIConstants.gray1Color,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    tabs: categories.map(
                      (e) {
                        return Tab(text: e.name ?? "");
                        // return SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.25,
                        //   child: Tab(text: e.name ?? ""),
                        // );
                      },
                    ).toList(),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: categories.map(
                      (category) {
                        return category.subcategories.isEmpty
                            ? const Center(child: NoResultWidget())
                            : ListView.separated(
                                shrinkWrap: true,
                                itemCount: category.subcategories.length,
                                itemBuilder: (context, index) {
                                  return SubCategoryWidget(
                                    subCategoryModel:
                                        category.subcategories[index],
                                    onClick: () {
                                      navigateTo(
                                        SubcategoryScreen(
                                            subcategoryModel:
                                                category.subcategories[index]),
                                        myContext: NavigationUtil
                                            .categoriesNavigatorKey
                                            .currentContext,
                                      );
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(height: 1.0);
                                },
                              );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SubCategoryWidget extends StatelessWidget {
  final CategoryModel subCategoryModel;
  final Function() onClick;

  const SubCategoryWidget({
    super.key,
    required this.subCategoryModel,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipOval(
              child: CachedImageWidget(
                imageUrl: subCategoryModel.cover ?? "",
                width: 50,
                height: 50,
              ),
            ),
            const HorizontalSpace(14.0),
            Expanded(
              child: Text(
                subCategoryModel.name ?? "",
                style: TextStyleConstants.bodyRegular.copyWith(
                  color: UIConstants.gray1Color,
                ),
              ),
            ),
            const HorizontalSpace(14.0),
            Image.asset(
              "assets/images/arrow_icon.png",
              matchTextDirection: true,
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
