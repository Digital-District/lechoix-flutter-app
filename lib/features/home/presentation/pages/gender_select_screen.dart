import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/ShimmerWidget.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_list_widget.dart';
import 'package:lechoix/features/home/presentation/bloc/gender_select_bloc.dart';
import 'package:lechoix/features/home/presentation/pages/home_screen.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/cache/user_cache.dart';
import '../../../../data/CategoryModel.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState
    extends BaseState<GenderSelectionScreen, GenderSelectionBloc> {
  @override
  void initBloc() {
    bloc = GenderSelectionBloc(this);
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
                localize("The Key to your Luxury Experience"),
                style: TextStyleConstants.captionRegular.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamListWidget<CategoryModel>(
                stream: bloc.controller.stream,
                onRetry: bloc.getCategories,
                loadingWidget: ShimmerWidget(child: getShimmerWidget()),
                child: (model) {
                  if (model.id == null) {
                    return SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          localize("Select The Desired Category"),
                          style: TextStyleConstants.bodyRegular.copyWith(
                            color: UIConstants.blackColor,
                          ),
                        ),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      onCategoryTaped(model);
                    },
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          CachedImageWidget(
                            imageUrl: model.cover ?? "",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Container(
                            color: UIConstants.blackColor.withOpacity(0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  model.name ?? "",
                                  style: TextStyleConstants.headline4.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void onCategoryTaped(CategoryModel model) {
    UserCache.instance.setCategoryId(model.id ?? 1);
    navigateTo(const HomeScreen(),
        myContext: NavigationUtil.homeNavigatorKey.currentContext);
  }

  getShimmerWidget() => ListView(
        padding: const EdgeInsets.all(8.0),
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Container(
                height: 150,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(UIConstants.radius),
                ),
              ),
            )
            .toList(),
      );
}
