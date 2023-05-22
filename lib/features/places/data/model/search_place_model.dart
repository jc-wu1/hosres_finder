import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'place_model.dart';

class SearchPlacesModel extends Equatable {
  final List<Candidate>? candidates;
  final String? errorMessage;
  final String? status;

  const SearchPlacesModel({
    this.candidates,
    this.errorMessage,
    this.status,
  });

  factory SearchPlacesModel.fromRawJson(String str) =>
      SearchPlacesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchPlacesModel.fromJson(Map<String, dynamic> json) =>
      SearchPlacesModel(
        candidates: json["candidates"] == null
            ? []
            : List<Candidate>.from(
                json["candidates"]!.map((x) => Candidate.fromJson(x))),
        errorMessage: json["error_message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "candidates": candidates == null
            ? []
            : List<dynamic>.from(candidates!.map((x) => x.toJson())),
        "error_message": errorMessage,
        "status": status,
      };

  @override
  List<Object?> get props => [
        candidates,
        errorMessage,
        status,
      ];
}

class Candidate extends Equatable {
  final String? formattedAddress;
  final Geometry? geometry;
  final String? name;
  final OpeningHours? openingHours;
  final double? rating;

  const Candidate({
    this.formattedAddress,
    this.geometry,
    this.name,
    this.openingHours,
    this.rating,
  });

  factory Candidate.fromRawJson(String str) =>
      Candidate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        formattedAddress: json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "name": name,
        "opening_hours": openingHours?.toJson(),
        "rating": rating,
      };

  @override
  List<Object?> get props => [
        formattedAddress,
        geometry,
        name,
        openingHours,
        rating,
      ];
}
