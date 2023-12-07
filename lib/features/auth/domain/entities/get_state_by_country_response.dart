class GetStateByCountryResponse {
  GetStateByCountryResponse({
    required this.result,
    required this.message,
    required this.code,
  });

  StateInfo result;
  String message;
  int code;

  factory GetStateByCountryResponse.fromJson(Map<String, dynamic> json) =>
      GetStateByCountryResponse(
        result: StateInfo.fromJson(json["result"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "message": message,
        "code": code,
      };
}

class StateInfo {
  StateInfo({
    required this.states,
  });

  List<States> states;

  factory StateInfo.fromJson(Map<String, dynamic> json) => StateInfo(
        states:
            List<States>.from(json["states"].map((x) => States.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
      };
}

class States {
  States({
    required this.stateId,
    required this.stateName,
    required this.code,
  });

  int stateId;
  String stateName;
  String code;

  factory States.fromJson(Map<String, dynamic> json) => States(
        stateId: json["state_id"],
        stateName: json["state_name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
        "code": code,
      };
}
