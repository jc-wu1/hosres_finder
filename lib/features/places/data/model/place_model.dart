import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final String? businessStatus;
  final Geometry? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? name;
  final OpeningHours? openingHours;
  final List<Photo>? photos;
  final String? placeId;
  final int? priceLevel;
  final int? rating;
  final String? reference;
  final String? scope;
  final List<String>? types;
  final int? userRatingsTotal;
  final String? vicinity;

  const PlaceModel({
    this.businessStatus,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.priceLevel,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
  });

  factory PlaceModel.fromRawJson(String str) =>
      PlaceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        businessStatus: json["business_status"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHours.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? []
            : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        priceLevel: json["price_level"],
        rating: json["rating"],
        reference: json["reference"],
        scope: json["scope"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatus,
        "geometry": geometry?.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours?.toJson(),
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId,
        "price_level": priceLevel,
        "rating": rating,
        "reference": reference,
        "scope": scope,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
      };

  @override
  List<Object?> get props => [
        businessStatus,
        geometry,
        icon,
        iconBackgroundColor,
        iconMaskBaseUri,
        name,
        openingHours,
        photos,
        placeId,
        priceLevel,
        rating,
        reference,
        scope,
        types,
        userRatingsTotal,
        vicinity,
      ];
}

class Geometry extends Equatable {
  final Location? location;

  const Geometry({
    this.location,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
      };

  @override
  List<Object?> get props => [location];
}

class Location extends Equatable {
  final double? lat;
  final double? lng;

  const Location({
    this.lat,
    this.lng,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  @override
  List<Object?> get props => [
        lat,
        lng,
      ];
}

class OpeningHours extends Equatable {
  final bool? openNow;

  const OpeningHours({
    this.openNow,
  });

  factory OpeningHours.fromRawJson(String str) =>
      OpeningHours.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };

  @override
  List<Object?> get props => [openNow];
}

class Photo extends Equatable {
  final int? height;
  final String? photoReference;
  final int? width;

  const Photo({
    this.height,
    this.photoReference,
    this.width,
  });

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "photo_reference": photoReference,
        "width": width,
      };

  @override
  List<Object?> get props => [
        height,
        photoReference,
        width,
      ];
}
