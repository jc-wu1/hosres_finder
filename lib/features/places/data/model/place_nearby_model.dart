import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hosres_finder/features/places/data/model/place_model.dart';

class PlaceNearbyModel extends Equatable {
  final List<PlaceModel>? result;
  final String? status;
  final String? errorMessage;

  const PlaceNearbyModel({
    this.result,
    this.status,
    this.errorMessage,
  });

  factory PlaceNearbyModel.fromRawJson(String str) =>
      PlaceNearbyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceNearbyModel.fromJson(Map<String, dynamic> json) =>
      PlaceNearbyModel(
        result: json["result"] == null
            ? []
            : List<PlaceModel>.from(
                json["result"]!.map(
                  (x) => PlaceModel.fromJson(x),
                ),
              ),
        status: json["status"],
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(
                result!.map(
                  (x) => x.toJson(),
                ),
              ),
        "status": status,
        "error_message": errorMessage,
      };

  @override
  List<Object?> get props => [
        result,
        status,
        errorMessage,
      ];
}
