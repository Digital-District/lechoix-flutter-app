import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/text_button_widget.dart';
import 'package:lechoix/core/widgets/more_widget.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/features/categories/presentation/pages/subcategory/subcategories_bloc.dart';

import '../../../../core/base/base_state.dart';
import '../../../../data/filtration/FiltrationCriteriaModel.dart';
import '../../../../data/filtration/FiltrationType.dart';
import 'filtration_screen.dart';

class MainFiltrationScreen extends StatefulWidget {
  final FiltrationCriteriaModel filtrationModel;

  const MainFiltrationScreen({super.key, required this.filtrationModel});

  @override
  _MainFiltrationScreenState createState() => _MainFiltrationScreenState();
}

class _MainFiltrationScreenState
    extends BaseState<MainFiltrationScreen, SubcategoriesBloc> {
  List<FiltrationItemModel> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("Filters")),
        actionIcon: TextButtonWidget(
          onClick: _clearAll,
          child: Text(
            localize("Clear All"),
            style: TextStyleConstants.captionRegular.copyWith(
              color: UIConstants.gray3Color,
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            localize("Sale"),
                            style: TextStyleConstants.bodyBold.copyWith(
                              color: UIConstants.gray1Color,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          height: 25,
                          child: Switch(
                            value: widget.filtrationModel.sale,
                            activeColor: Theme.of(context).colorScheme.primary,
                            activeTrackColor:
                                Theme.of(context).colorScheme.onPrimary,
                            inactiveThumbColor: UIConstants.gray4Color,
                            onChanged: (value) {
                              widget.filtrationModel.sale = value;
                              _callFiltrationAPI();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(height: 1.0),
                  Column(
                    children: items.map(
                      (model) {
                        return Column(
                          children: [
                            MoreWidget(
                              title: localize(model.title),
                              onClick: () async {
                                List<int> list = [];
                                list.addAll(model.ids);
                                var result = await navigateTo(FiltrationScreen(
                                  list,
                                  model.type,
                                  model.title,
                                  filtrationModel: widget.filtrationModel,
                                ));
                                if (result != null) {
                                  model.ids = result;
                                  _callFiltrationAPI();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    child: Text(
                        "${localize("SHOW")} ${widget.filtrationModel.productsCount} ${localize("RESULTS")}"),
                    onClick: () {
                      Navigator.pop(context, widget.filtrationModel);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initBloc() {
    bloc = SubcategoriesBloc(this);
    _configureViewWithData();
  }

  _configureViewWithData() {
    items.add(
      FiltrationItemModel(FiltrationType.categories, "Category",
          widget.filtrationModel.categories),
    );
    items.add(
      FiltrationItemModel(FiltrationType.designers, "Designers",
          widget.filtrationModel.designers),
    );
    items.add(
      FiltrationItemModel(FiltrationType.clothingSize, "Clothing size",
          widget.filtrationModel.clothingSize),
    );
    items.add(
      FiltrationItemModel(
          FiltrationType.colors, "Colors", widget.filtrationModel.colors),
    );
    items.add(
      FiltrationItemModel(FiltrationType.priceRange, "Price range",
          widget.filtrationModel.priceRange),
    );
  }

  _updateFiltrationAPI() {
    widget.filtrationModel.categories = items[0].ids;
    widget.filtrationModel.designers = items[1].ids;
    widget.filtrationModel.clothingSize = items[2].ids;
    widget.filtrationModel.colors = items[3].ids;
    widget.filtrationModel.priceRange = items[4].ids;
    log("${widget.filtrationModel.priceRange}");
    log("${widget.filtrationModel}");
  }

  _callFiltrationAPI() async {
    _updateFiltrationAPI();

    bloc.setFiltrationModel(widget.filtrationModel);
    var productsResponse = await bloc.getProductsCount();
    if (productsResponse != null) {
      int count = productsResponse.pagination?.total ?? 0;
      widget.filtrationModel.productsCount = count.toString();
      setState(() {});
    }
  }

  _clearAll() {
    widget.filtrationModel.clear();
    items[0].ids = [];
    items[1].ids = [];
    items[2].ids = [];
    items[3].ids = [];
    items[4].ids = [];

    _callFiltrationAPI();
    setState(() {});
  }
}
