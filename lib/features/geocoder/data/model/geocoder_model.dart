// To parse this JSON data, do
//
//     final geocoderModel = geocoderModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../places/data/model/place_model.dart';

class GeocoderModel extends Equatable {
  final List<Result>? results;
  final String? status;
  final String? errorMsg;

  const GeocoderModel({
    this.results,
    this.status,
    this.errorMsg,
  });

  factory GeocoderModel.fromRawJson(String str) =>
      GeocoderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeocoderModel.fromJson(Map<String, dynamic> json) => GeocoderModel(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        status: json["status"],
        errorMsg: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
        "error_message": errorMsg,
      };

  @override
  List<Object?> get props => [
        results,
        status,
        errorMsg,
      ];
}

class Result extends Equatable {
  final List<AddressComponent>? addressComponents;
  final String? formattedAddress;
  final Geometry? geometry;
  final String? placeId;
  final PlusCode? plusCode;
  final List<String>? types;

  const Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.plusCode,
    this.types,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        addressComponents: json["address_components"] == null
            ? []
            : List<AddressComponent>.from(json["address_components"]!
                .map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCode.fromJson(json["plus_code"]),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? []
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };

  @override
  List<Object?> get props => [
        addressComponents,
        formattedAddress,
        geometry,
        placeId,
        plusCode,
        types,
      ];
}

class AddressComponent extends Equatable {
  final String? longName;
  final String? shortName;
  final List<String>? types;

  const AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  factory AddressComponent.fromRawJson(String str) =>
      AddressComponent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };

  @override
  List<Object?> get props => [
        longName,
        shortName,
        types,
      ];
}

class PlusCode extends Equatable {
  final String? compoundCode;
  final String? globalCode;

  const PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  factory PlusCode.fromRawJson(String str) =>
      PlusCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };

  @override
  List<Object?> get props => [
        compoundCode,
        globalCode,
      ];
}
