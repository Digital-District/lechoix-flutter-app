import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/cache/country_codes_cache.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/button/text_button_widget.dart';
import 'package:lechoix/core/widgets/dialog/selection_dialog.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/data/model/CountryCodeModel.dart';
import 'text_field_widget.dart';

class PhoneTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final String? hint;
  final Function(CountryCodeModel?) onCountyCodeSelected;
  final bool readOnly;
  final Function()? onClick;
  final Widget? suffixIcon;

  const PhoneTextFieldWidget({
    super.key,
    required this.controller,
    this.errorText,
    this.hint,
    required this.onCountyCodeSelected,
    this.readOnly = false,
    this.onClick,
    this.suffixIcon,
  });

  @override
  State<PhoneTextFieldWidget> createState() => _PhoneTextFieldWidgetState();
}

class _PhoneTextFieldWidgetState extends State<PhoneTextFieldWidget> {
  CountryCodeModel? countryCodeModel;

  @override
  void initState() {
    _setCountyCode(CountryCodesCache.instance.firstOrNull, shouldClear: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: widget.controller,
      hint: widget.hint,
      errorText: widget.errorText,
      readOnly: widget.readOnly,
      onClick: widget.onClick,
      suffixIcon: widget.suffixIcon,
      keyboardType: TextInputType.phone,
      prefixIcon: TextButtonWidget(
        padding: EdgeInsets.zero,
        onClick: _showCountyCodesDialog,
        child: Text("${countryCodeModel?.code ?? ""} ▼"),
      ),
    );
  }

  void _showCountyCodesDialog() {
    if (CountryCodesCache.instance.countryCodes.length > 1) {
      showModal(
        context: context,
        builder: (BuildContext context) {
          return SelectionDialog(
            children: CountryCodesCache.instance.countryCodes.map((element) {
              return CountyCodeWidget(
                countryCodeModel: element,
                onClick: () {
                  setState(() {
                    _setCountyCode(element);
                    Navigator.pop(context);
                  });
                },
              );
            }).toList(),
          );
        },
      );
    }
  }

  void _setCountyCode(
    CountryCodeModel? countryCodeModel, {
    bool shouldClear = true,
  }) {
    if (this.countryCodeModel != countryCodeModel) {
      this.countryCodeModel = countryCodeModel;
      if (shouldClear) widget.controller.clear();
      widget.onCountyCodeSelected(countryCodeModel);
    }
  }
}

class CountyCodeWidget extends StatelessWidget {
  final CountryCodeModel countryCodeModel;
  final Function() onClick;

  const CountyCodeWidget({
    super.key,
    required this.countryCodeModel,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: UIConstants.gray6Color,
                shape: BoxShape.circle,
              ),
              child: CachedImageWidget(
                imageUrl: countryCodeModel.flag ?? "",
                maxHeightDiskCache: 48,
                maxWidthDiskCache: 48,
              ),
            ),
            const HorizontalSpace(16.0),
            Expanded(
              child: Text(
                countryCodeModel.codeWithName,
                style: TextStyleConstants.titleRegular.copyWith(
                  color: UIConstants.gray1Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
