import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/button/icon_button_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';

class SelectionBottomSheetWidget<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final Function(T) onSelectItem;
  final Widget? bottomWidget;

  const SelectionBottomSheetWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onSelectItem,
    this.selectedItem,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButtonWidget(
                icon: Container(),
                padding: EdgeInsets.zero,
                onClick: null,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.titleRegular.copyWith(
                    color: UIConstants.gray1Color,
                  ),
                ),
              ),
              IconButtonWidget(
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
                onClick: () {
                  NavigationUtil.pop(context);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView(
              shrinkWrap: true,
              children: items.map(
                (e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          onSelectItem(e);
                          NavigationUtil.pop(context);
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  e.toString(),
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyleConstants.bodyRegular.copyWith(
                                    color: UIConstants.gray1Color,
                                  ),
                                ),
                                Visibility(
                                  visible: selectedItem == e,
                                  child: const Row(
                                    children: [
                                      HorizontalSpace(16),
                                      Icon(
                                        Icons.check,
                                        color: UIConstants.gray2Color,
                                        size: 16.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      const Divider(height: 1.0),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
        bottomWidget ?? Container(),
        const VerticalSpace(40),
      ],
    );
  }
}

void showSelectionBottomSheet<T>(
  BuildContext context,
  String title,
  List<T> items,
  Function(T) onSelectItem, {
  T? selectedItem,
  Widget? bottomWidget,
}) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.75,
        expand: false,
        builder: (_, controller) {
          return SelectionBottomSheetWidget(
            title: title,
            items: items,
            onSelectItem: onSelectItem,
            bottomWidget: bottomWidget,
            selectedItem: selectedItem,
          );
        },
      );
    },
  );
}

class SortItemModel {
  String id;
  String title;

  SortItemModel(this.id, this.title);

  @override
  String toString() {
    return title;
  }
}
