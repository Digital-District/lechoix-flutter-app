import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/filter/presentation/widgets/filtered_product_grid_widget.dart';

import '../../core/base/base_state.dart';
import '../../core/base/dummy_bloc.dart';

class SearchScreen extends StatefulWidget {
  final int categoryId;

  const SearchScreen({super.key, required this.categoryId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseState<SearchScreen, DummyBloc> {
  @override
  void initBloc() {
    bloc = DummyBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.search(
        centerWidget: const Text("Search"),
        onSubmitSearch: (searchValue) {
          FilteredProductGridWidget.productsKeyState.currentState
              ?.search(searchValue);
        },
      ),
      body: Column(
        children: [
          const VerticalSpace(24),
          Expanded(
            child: FilteredProductGridWidget(
              categoryId: widget.categoryId,
              brandId: -1,
              key: FilteredProductGridWidget.productsKeyState,
            ),
          )
        ],
      ),
    );
  }
}
