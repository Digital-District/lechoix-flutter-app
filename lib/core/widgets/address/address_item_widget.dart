import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/data/address/AddressModel.dart';
import 'package:lechoix/core/widgets/button/label_with_icon_widget.dart';
import 'package:lechoix/core/widgets/button/text_button_widget.dart';
import '../space_widget.dart';

class AddressItemWidget extends StatefulWidget {
  final AddressModel model;
  final bool isCameFromCart;
  final int currentShippingAddressID;
  final Function()? onClick;
  final Function()? onEditClick;
  final Function()? setDefaultAction;

  const AddressItemWidget({
    super.key,
    required this.model,
    required this.isCameFromCart,
    required this.currentShippingAddressID,
    this.onClick,
    this.setDefaultAction,
    this.onEditClick,
  });

  @override
  _AddressItemWidgetState createState() => _AddressItemWidgetState();
}

class _AddressItemWidgetState extends State<AddressItemWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onClick,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Visibility(
                    visible: widget.isCameFromCart,
                    child: Row(
                      children: [
                        widget.currentShippingAddressID == widget.model.id!
                            ? const Icon(Icons.check_circle_rounded)
                            : const Icon(Icons.circle_outlined),
                        const HorizontalSpace(8),
                      ],
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.getName(),
                        style: TextStyleConstants.bodyBold,
                      ),
                      const VerticalSpace(10),
                      Text(
                        widget.model.getFullAddress(),
                        style: TextStyleConstants.bodyRegular,
                      ),
                      const VerticalSpace(6),
                      Text(
                        widget.model.getLocation(),
                        style: TextStyleConstants.bodyRegular,
                      ),
                      const VerticalSpace(6),
                      Text(
                        widget.model.phone ?? "",
                        style: TextStyleConstants.bodyRegular,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !widget.isCameFromCart,
                  child: Image.asset(
                    "assets/images/arrow_icon.png",
                    matchTextDirection: true,
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          indent: 25,
          endIndent: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Visibility(
                visible: !widget.isCameFromCart,
                child: GestureDetector(
                  onTap: onSetDefaultAction,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: widget.model.isDefault,
                        onChanged: (bool? value) {
                          onSetDefaultAction();
                        },
                      ),
                      Text(
                        widget.model.isDefault ?? false
                            ? tr("Default")
                            : tr("Set As Default Address"),
                        style: TextStyleConstants.captionBold.copyWith(
                          color: UIConstants.gray1Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: (widget.isCameFromCart &&
                    (widget.model.isDefault ?? false)),
                child: Container(
                  decoration: BoxDecoration(
                    color: UIConstants.gray5Color,
                    borderRadius: BorderRadius.circular(UIConstants.radius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: Text(
                      tr("Default"),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Visibility(
                visible: widget.isCameFromCart,
                child: TextButtonWidget(
                  padding: EdgeInsets.zero,
                  onClick: widget.onEditClick,
                  child: LabelWithIconWidget(
                    label: tr("Edit"),
                    icon: const Icon(Icons.edit),
                    textPadding:
                        const EdgeInsets.symmetric(vertical: UIConstants.padding),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            height: 1,
          ),
        ),
      ],
    );
  }

  void onSetDefaultAction() {
    if (!(widget.model.isDefault ?? false)) {
      widget.setDefaultAction?.call();
    }
  }
}
