// To parse this JSON data, do
//
//     final countriesResponse = countriesResponseFromMap(jsonString);

import 'dart:convert';

CountriesResponse countriesResponseFromMap(String str) => CountriesResponse.fromMap(json.decode(str));

String countriesResponseToMap(CountriesResponse data) => json.encode(data.toMap());

class CountriesResponse {
    CountriesData? data;

    CountriesResponse({
        this.data,
    });

    factory CountriesResponse.fromMap(Map<String, dynamic> json) => CountriesResponse(
        data: json["data"] == null ? null : CountriesData.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
    };
}

class CountriesData {
    List<Country>? countries;

    CountriesData({
        this.countries,
    });

    factory CountriesData.fromMap(Map<String, dynamic> json) => CountriesData(
        countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toMap())),
    };
}

class Country {
    String? fullNameEnglish;
    String? fullNameLocale;
    String? id;
    String? threeLetterAbbreviation;
    String? twoLetterAbbreviation;

    Country({
        this.fullNameEnglish,
        this.fullNameLocale,
        this.id,
        this.threeLetterAbbreviation,
        this.twoLetterAbbreviation,
    });

    factory Country.fromMap(Map<String, dynamic> json) => Country(
        fullNameEnglish: json["full_name_english"],
        fullNameLocale: json["full_name_locale"],
        id: json["id"],
        threeLetterAbbreviation: json["three_letter_abbreviation"],
        twoLetterAbbreviation: json["two_letter_abbreviation"],
    );

    Map<String, dynamic> toMap() => {
        "full_name_english": fullNameEnglish,
        "full_name_locale": fullNameLocale,
        "id": id,
        "three_letter_abbreviation": threeLetterAbbreviation,
        "two_letter_abbreviation": twoLetterAbbreviation,
    };
}
