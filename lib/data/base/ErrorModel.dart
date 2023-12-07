class ErrorResponse {
  int errorCode = 0;
  String? message;
  ErrorModelList? errors;

  ErrorResponse({
    this.message,
    this.errors,
  });

  void setErrors(dynamic json) {
    errors =
        json['errors'] != null ? ErrorModelList.fromJson(json['errors']) : null;
  }

  String? getError(String key) {
    List<ErrorModel> errorList = errors?.errorList ?? [];
    for (var error in errorList) {
      if (error.key == key) {
        return error.value;
      }
    }
    return null;
  }
}

class ErrorModelList {
  List<ErrorModel> errorList = [];

  ErrorModelList.fromJson(Map json) {
    json.forEach((kay, value) {
      List<String> valueList = [];
      valueList = List.from(value);
      errorList.add(ErrorModel(kay, valueList[0]));
    });
  }
}

class ErrorModel {
  String key = "";
  String value = "";

  ErrorModel(this.key, this.value);
}
