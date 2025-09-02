import 'package:get/get.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';

class RideModel {
  String? id;
  String? rider;
  String? driver;
  RxString? status;

  LocationModel? pickupLocation;
  LocationModel? dropOffLocation;

  num? fare;
  DateTime? requestedAt;
  String? paymentMethod;
  String? paymentStatus;

  String? transactionId;
  num? amountPaid;

  bool? ratedByRider;
  bool? ratedByDriver;
  List<LocationModel>? stops;

  final UserModel? driverModel;
  final UserModel? riderModel;
  final int? rating;

  //for json only fields not from backend
  int? carSeat;
  bool? wheelChairAccessible;
  final DateTime? createdAt;

 RxBool isExpanded = false.obs;

  RideModel({
    this.id,
    this.rider,
    this.driver,
    this.status,
    this.pickupLocation,
    this.dropOffLocation,
    this.fare,
    this.requestedAt,
    this.paymentMethod,
    this.paymentStatus,
    this.transactionId,
    this.amountPaid,
    this.ratedByRider,
    this.ratedByDriver,
    this.stops,

    this.driverModel,
    this.riderModel,
    this.rating,

    this.carSeat,
    this.wheelChairAccessible,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (carSeat != null) {
      data["carSeat"] = carSeat;
    }
    if (wheelChairAccessible != null) {
      data["wheelChairAccessible"] = wheelChairAccessible;
    }
    if (pickupLocation != null) {
      data["pickupLocation"] = pickupLocation!.toJson();
    }
    if (dropOffLocation != null) {
      data["dropoffLocation"] = dropOffLocation!.toJson();
    }
    return data;
  }

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json["id"] ?? json["_id"],
      rider: json["rider"] ?? "",
      driver: json["driver"] ?? "",
      status: RxString(json["status"] ?? ""),
      pickupLocation: json["pickup_location"] != null
          ? LocationModel.fromJson(json["pickup_location"])
          : null,
      dropOffLocation: json["dropoff_location"] != null
          ? LocationModel.fromJson(json["dropoff_location"])
          : null,
      fare: json['fare'] != null ? num.tryParse(json['fare'].toString()) : null,
      requestedAt: json["requested_at"] != null
          ? DateTime.parse(json["requested_at"])
          : null,
      paymentMethod: json["payment_method"] ?? "",
      paymentStatus: json["payment_status"] ?? "",
      transactionId: json["transaction_id"] ?? "",
      amountPaid: json['amount_paid'] != null
          ? num.tryParse(json['amount_paid'].toString())
          : null,
      ratedByRider: json["rated_by_rider"] ?? false,
      ratedByDriver: json["rated_by_driver"] ?? false,
      stops: json["stops"] != null
          ? List<LocationModel>.from(
              json["stops"].map((x) => LocationModel.fromJson(x)),
            )
          : null,

      driverModel: json["driverProfile"] != null
          ? UserModel.fromJson(json["driverProfile"])
          : null,
      riderModel: json["riderProfile"] != null
          ? UserModel.fromJson(json["riderProfile"])
          : null,
      rating: json["rating"] ?? 0,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : null,
    );
  }

  @override
  String toString() {
    return 'RideModel(id: $id, rider: $rider, driver: $driver, status: $status, pickupLocation: $pickupLocation, dropOffLocation: $dropOffLocation, fare: $fare, requestedAt: $requestedAt, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, transactionId: $transactionId, amountPaid: $amountPaid, ratedByRider: $ratedByRider, ratedByDriver: $ratedByDriver, stops: $stops, carSeat: $carSeat, wheelChairAccessible: $wheelChairAccessible)';
  }
}
