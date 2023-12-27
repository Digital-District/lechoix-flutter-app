import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/button/icon_button_widget.dart';
import 'package:lechoix/core/widgets/subtitle_appbar_widget.dart';
import 'package:lechoix/features/filter/presentation/widgets/filtered_product_grid_widget.dart';
import 'package:lechoix/features/search/search_screen.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/base/dummy_bloc.dart';
import '../../../../../data/CategoryModel.dart';

class SubcategoryScreen extends StatefulWidget {
  final CategoryModel subcategoryModel;

  const SubcategoryScreen({super.key, required this.subcategoryModel});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends BaseState<SubcategoryScreen, DummyBloc> {
  String _productCount = "0";

  @override
  void initBloc() {
    bloc = DummyBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubtitleAppBarWidget(
        title: Text(
          widget.subcategoryModel.name ?? "",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          "$_productCount ${localize("items")}",
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        actionIcon: IconButtonWidget(
          icon: Image.asset("assets/images/ic_search.png"),
          onClick: () {
            navigateTo(
                SearchScreen(categoryId: widget.subcategoryModel.id ?? 0));
          },
        ),
      ),
      body: FilteredProductGridWidget(
        categoryId: widget.subcategoryModel.id ?? -1,
        brandId: -1,
        onItemCountUpdated: (newCount) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _productCount = newCount;
            });
          });
        },
      ),
    );
  }
}
