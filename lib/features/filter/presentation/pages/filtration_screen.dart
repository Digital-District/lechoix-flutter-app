import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/text_button_widget.dart';
import 'package:lechoix/core/widgets/filtration_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_list_widget.dart';
import 'package:lechoix/data/Enumeration.dart';
import 'package:lechoix/data/filtration/FiltrationCriteriaModel.dart';
import 'package:lechoix/features/filter/presentation/cubit/filtration_bloc.dart';
import '../../../../core/base/base_state.dart';
import '../../../../data/filtration/FiltrationDataModel.dart';

class FiltrationScreen extends StatefulWidget {
  final List<int> selectedIds;
  final FiltrationType type;
  final String title;
  final FiltrationCriteriaModel filtrationModel;

  const FiltrationScreen(this.selectedIds, this.type, this.title,
      {super.key, required this.filtrationModel});

  @override
  _FiltrationScreenState createState() => _FiltrationScreenState();
}

class _FiltrationScreenState
    extends BaseState<FiltrationScreen, FiltrationBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize(widget.title)),
        actionIcon: TextButtonWidget(
          child: Text(
            localize("Clear"),
            style: TextStyleConstants.captionRegular.copyWith(
              color: UIConstants.gray3Color,
            ),
          ),
          onClick: () {
            bloc.clear();
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            StreamListWidget<FiltrationDataModel>(
                stream: bloc.controller.stream,
                onRetry: bloc.getData,
                padding: const EdgeInsets.only(bottom: 150),
                child: (model) {
                  return FiltrationWidget(
                    title: model.name,
                    isSelected: model.isSelected,
                    img: model.image,
                    onClick: () {
                      bloc.updateSelectedOptions(model);
                    },
                  );
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonWidget(
                    child: Text(localize("SHOW")),
                    onClick: () {
                      Navigator.pop(context, bloc.ids);
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
    bloc = FiltrationBloc(this, widget.type, widget.selectedIds,
        widget.filtrationModel.categoryId, widget.filtrationModel.brandId);
  }
}
