import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/validation_util.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/drop_down_widget.dart';
import 'package:lechoix/core/widgets/need_help_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/core/widgets/textField/input_field_widget.dart';
import 'package:lechoix/core/widgets/textField/phone_text_field_widget.dart';
import 'package:lechoix/core/widgets/textField/text_field_widget.dart';
import 'package:lechoix/data/address/locations/LocationsResponse.dart';
import 'package:lechoix/features/address/presentation/cubit/add_address_bloc.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../data/address/AddAddressRequestModel.dart';
import '../../../../../data/address/AddressModel.dart';
import '../../../../../data/address/locations/LocationModel.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? oldAddressModel;
  final bool isCameFromCart;

  const AddAddressScreen(
      {super.key, this.oldAddressModel, required this.isCameFromCart});

  @override
  AddAddressScreenState createState() => AddAddressScreenState();
}

class AddAddressScreenState
    extends BaseState<AddAddressScreen, AddAddressBloc> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _detailsAddressController =
      TextEditingController();

  String? _firstNamError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _cityError;
  String? _areaError;
  String? _deliveryAddressError;
  String? _detailsAddressError;

  bool _isEligibleToContinue = false;
  int phoneCountryCodeId = 1;
  String phoneRegex = "";

  bool isAddMood = true;
  bool isDefault = false;
  String screenTitle = "Add New Address";
  String primaryActionTitle = "ADD ADDRESS";

  LocationsResponse? locationsResponse;
  LocationModel? _selectedCity;
  LocationModel? _selectedArea;
  bool isLocationSet = false;

  @override
  void initBloc() {
    bloc = AddAddressBloc(this);
    if (widget.oldAddressModel != null) {
      isAddMood = false;
      screenTitle = "Update Address";
      primaryActionTitle = "UPDATE ADDRESS";

      _firstNameController.text = widget.oldAddressModel?.firstName ?? "";
      _lastNameController.text = widget.oldAddressModel?.lastName ?? "";
      _emailController.text = widget.oldAddressModel?.email ?? "";

      _deliveryAddressController.text =
          widget.oldAddressModel?.deliveryAddress ?? "";
      _detailsAddressController.text =
          widget.oldAddressModel?.description ?? "";
      isDefault = widget.oldAddressModel?.isDefault ?? false;
      log("-----------------");
      _phoneController.text = widget.oldAddressModel?.phone ?? "";
    }
  }

  void setLocation() {
    _selectedCity =
        locationsResponse?.getCityById(widget.oldAddressModel?.city?.id ?? 0);
    _selectedArea =
        _selectedCity?.getAreaById(widget.oldAddressModel?.area?.id ?? 0);
    isLocationSet = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize(screenTitle))),
      body: StreamWidget<LocationsResponse?>(
        stream: bloc.locationsController.stream,
        onRetry: bloc.getLocations,
        child: (response) {
          locationsResponse = response;
          if (!isLocationSet) setLocation();
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const VerticalSpace(16.0),
                      InputFieldWidget(
                        label: "First Name*",
                        bottomWidget: TextFieldWidget(
                          controller: _firstNameController,
                          hint: "Enter your first name",
                          errorText: _firstNamError,
                        ),
                      ),
                      InputFieldWidget(
                        label: "Last Name*",
                        bottomWidget: TextFieldWidget(
                          controller: _lastNameController,
                          hint: "Enter your last name",
                          errorText: _lastNameError,
                        ),
                      ),
                      InputFieldWidget(
                        label: "Email address*",
                        bottomWidget: TextFieldWidget(
                          controller: _emailController,
                          hint: "e.g. mail@example.com",
                          errorText: _emailError,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      InputFieldWidget(
                        label: "Phone number*",
                        bottomWidget: PhoneTextFieldWidget(
                          controller: _phoneController,
                          hint: "55123456",
                          errorText: _phoneError,
                          onCountyCodeSelected: (countryCodeModel) {
                            phoneRegex = countryCodeModel?.regex ?? "";
                            phoneCountryCodeId = countryCodeModel?.id ?? 0;
                          },
                        ),
                      ),
                      InputFieldWidget(
                        label: "City*",
                        bottomWidget: FormField<LocationModel>(
                          builder: (FormFieldState<LocationModel> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 2.0),
                                errorText: _cityError,
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: UIConstants.redColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: UIConstants.gray4Color,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: UIConstants.gray4Color,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: UIConstants.gray1Color,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: UIConstants.gray1Color),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: UIConstants.gray1Color),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                              ),
                              isEmpty: _selectedCity == null,
                              child: DropDownWidget<LocationModel>(
                                items: locationsResponse?.cities ?? [],
                                hint: localize(
                                  "e.g Doha",
                                ),
                                selectedItem: _selectedCity,
                                onItemSelected: (item) {
                                  setState(() {
                                    _selectedCity = item;
                                    _selectedArea = null;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      InputFieldWidget(
                        label: "Area*",
                        bottomWidget: FormField<LocationModel>(
                          builder: (FormFieldState<LocationModel> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 2.0),
                                errorText: _areaError,
                                errorStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: UIConstants.redColor,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: UIConstants.gray4Color,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: UIConstants.gray4Color,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: UIConstants.gray1Color,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: UIConstants.gray1Color),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: UIConstants.gray1Color),
                                  borderRadius:
                                      BorderRadius.circular(UIConstants.radius),
                                ),
                              ),
                              isEmpty: _selectedArea == null,
                              child: DropDownWidget<LocationModel>(
                                items: _selectedCity?.areas ?? [],
                                hint: localize("e.g West bay"),
                                selectedItem: _selectedArea,
                                onItemSelected: (item) {
                                  setState(() {
                                    _selectedArea = item;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      // InputFieldWidget(
                      //   label: "City*",
                      //   bottomWidget: TextFieldWidget(
                      //     controller: _cityController,
                      //     hint: "e.g. Doha",
                      //     errorText: _cityError,
                      //   ),
                      // ),
                      // InputFieldWidget(
                      //   label: "Area*",
                      //   bottomWidget: TextFieldWidget(
                      //     controller: _areaController,
                      //     hint: "e.g West bay",
                      //     errorText: _areaError,
                      //   ),
                      // ),
                      InputFieldWidget(
                        label: "Delivery Address*",
                        bottomWidget: TextFieldWidget(
                          controller: _deliveryAddressController,
                          hint: "e.g Building name / street",
                          errorText: _deliveryAddressError,
                        ),
                      ),
                      InputFieldWidget(
                        label: "Apartment# / Hotel Room# / Villa# (optional)",
                        bottomWidget: TextFieldWidget(
                          controller: _detailsAddressController,
                          hint: "e.g Apartment 201",
                          errorText: _detailsAddressError,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isDefault = !isDefault;
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: UIConstants.blackColor,
                              value: isDefault,
                              onChanged: (bool? value) {
                                isDefault = value ?? false;
                                setState(() {});
                              },
                            ),
                            Expanded(
                              child: Text(
                                localize("Set As Default Address"),
                                style: TextStyleConstants.captionBold.copyWith(
                                  color: UIConstants.gray1Color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalSpace(24),
                      ElevatedButtonWidget(
                        onClick: _addAddress,
                        child: Text(localize(primaryActionTitle)),
                      ),
                      const VerticalSpace(24),
                      Visibility(
                        visible: !isAddMood && !widget.isCameFromCart,
                        child: OutlinedButtonWidget(
                          borderColor: UIConstants.blackColor,
                          onClick: _deleteAddress,
                          child: Text(localize("DELETE ADDRESS")),
                        ),
                      )
                    ],
                  ),
                ),
                const NeedHelpWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _addAddress() async {
    _isValid();
    if (_isEligibleToContinue) {
      var firstName = _firstNameController.getText();
      var lastName = _lastNameController.getText();
      var email = _emailController.getText();
      var phone = _phoneController.getText();
      var deliveryAddress = _deliveryAddressController.getText();
      var detailsAddress = _detailsAddressController.getText();
      log("------sdsdsdsd--------");
      log(deliveryAddress.length as String);
      log(detailsAddress.length as String);

      AddAddressRequestModel requestModel = AddAddressRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          cityId: _selectedCity?.id ?? 0,
          areaId: _selectedArea?.id ?? 0,
          countryCode: "2",
          deliveryAddress: deliveryAddress,
          description: detailsAddress,
          isDefault: isDefault);
      if (isAddMood) {
        _addNewAddress(requestModel);
      } else {
        _updateAddress(requestModel);
      }
    }
  }

  _addNewAddress(AddAddressRequestModel requestModel) {
    bloc.addAddress(requestModel).then((value) {
      if (value) {
        Navigator.pop(context, true);
      } else {
        mangeApiError();
      }
    });
  }

  _updateAddress(AddAddressRequestModel requestModel) {
    bloc
        .updateAddress(requestModel, widget.oldAddressModel?.id ?? 0)
        .then((value) {
      if (value) {
        Navigator.pop(context, true);
      } else {
        mangeApiError();
      }
    });
  }

  _deleteAddress() {
    bloc.deleteAddress(widget.oldAddressModel?.id ?? 0).then((value) {
      if (value) {
        Navigator.pop(context, true);
      }
    });
  }

  void _isValid() {
    _isEligibleToContinue = true;
    _emailError = null;
    _lastNameError = null;
    _firstNamError = null;
    _phoneError = null;
    _cityError = null;
    _areaError = null;
    _detailsAddressError = null;
    _deliveryAddressError = null;

    if (!_emailController.isValidEmail()) {
      _emailError = localize("Enter a valid email");
      _isEligibleToContinue = false;
    }
    if (!_firstNameController.isValidName()) {
      _firstNamError = localize("Enter a valid first name");
      _isEligibleToContinue = false;
    }
    if (!_lastNameController.isValidName()) {
      _lastNameError = localize("Enter a valid last name");
      _isEligibleToContinue = false;
    }
    if (!_phoneController.isValidPhone(phoneRegex)) {
      _phoneError = localize("Enter a valid phone number");
      _isEligibleToContinue = false;
    }

    if (_selectedCity == null) {
      _cityError = localize("Enter a valid city");
      _isEligibleToContinue = false;
    }
    if (_selectedArea == null) {
      _areaError = localize("Enter a valid area");
      _isEligibleToContinue = false;
    }
    if (_deliveryAddressController.isEmpty()) {
      _deliveryAddressError = localize("Enter a valid delivery address");
      _isEligibleToContinue = false;
    }

    setState(() {});
  }

  void mangeApiError() {
    _firstNamError = bloc.getValidationError("first_name");
    _lastNameError = bloc.getValidationError("last_name");
    _emailError = bloc.getValidationError("email");
    _phoneError = bloc.getValidationError("phone");
    _cityError = bloc.getValidationError("city_id");
    _areaError = bloc.getValidationError("area_id");
    _deliveryAddressError = bloc.getValidationError("delivery_address");

    setState(() {});
  }
}
