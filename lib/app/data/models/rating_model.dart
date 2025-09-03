import 'package:ridexpressdriver/app/data/models/user_model.dart';

class RatingModel {
  final int? id;
  final UserModel? rider;
  final UserModel? driver;

  final double? riderRating;
  final String? riderComment;

  final double? driverRating;
  final String? driverComment;

  final DateTime? createdAt;

  RatingModel({
    this.id,
    this.rider,
    this.driver,
    this.riderRating,
    this.riderComment,
    this.driverRating,
    this.driverComment,
    this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json["id"] ?? 0,
      rider: json["rider"] != null ? UserModel.fromJson(json["rider"]) : null,
      driver: json["driver"] != null
          ? UserModel.fromJson(json["driver"])
          : null,
      riderRating: json["riderRating"] ?? 0,
      riderComment: json["riderComment"] ?? "",
      driverRating: json["driverRating"] ?? 0,
      driverComment: json["driverComment"] ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }
}
