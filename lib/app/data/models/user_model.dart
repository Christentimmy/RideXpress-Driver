

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? role;

  String? accountStatus;
  String? availabilityStatus;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? avatar;
  // List<AddressModel>? address;

  LocationModel? location;
  DriverProfile? driverProfile;
  DateTime? createdAt;
  double? totalAvgRating;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.accountStatus,
    this.availabilityStatus,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.avatar,
    // this.address,
    this.location,
    this.driverProfile,
    this.createdAt,
    this.totalAvgRating,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json["_id"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      password: json["password"] ?? "",
      role: json["role"] ?? "",
      accountStatus: json["account_status"] ?? "",
      availabilityStatus: json["availability_status"] ?? "",
      isEmailVerified: json["isEmailVerified"] ?? false,
      isPhoneVerified: json["isPhoneVerified"] ?? false,
      avatar: json["avatar"] ?? "",
      location: json["location"] != null
          ? LocationModel.fromJson(json["location"])
          : null,
      driverProfile: json["driverProfile"] != null
          ? DriverProfile.fromJson(json["driverProfile"])
          : null,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
      totalAvgRating: (json["rating"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (firstName != null && firstName!.isNotEmpty) {
      data["first_name"] = firstName;
    }
    if (lastName != null && lastName!.isNotEmpty) {
      data["last_name"] = lastName;
    }
    if (email != null && email!.isNotEmpty) {
      data["email"] = email;
    }
    if (password != null && password!.isNotEmpty) {
      data["password"] = password;
    }
    if (driverProfile?.state != null && driverProfile!.state!.isNotEmpty) {
      data["state"] = driverProfile!.state;
    }
    if (driverProfile?.city != null && driverProfile!.city!.isNotEmpty) {
      data["city"] = driverProfile!.city;
    }
    return data;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, password: $password, role: $role, accountStatus: $accountStatus, availabilityStatus: $availabilityStatus, isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, avatar: $avatar, location: $location)';
  }
}

class DriverProfile {
  final int? carSeat;
  final String? vehicleRegNumber;
  final String? carColor;
  final String? carModel;
  final String? carPlate;
  final String? licenseNumber;
  final DateTime? licenseExpiry;
  final bool? isVerified;
  final bool? isProfileCompleted;
  final String? city;
  final String? state;
  final String? country;
  final int? allTrips;
  final String? vehicleYear;

  DriverProfile({
    this.carSeat,
    this.carModel,
    this.carPlate,
    this.licenseNumber,
    this.licenseExpiry,
    this.isVerified,
    this.isProfileCompleted,
    this.city,
    this.state,
    this.country,
    this.allTrips,
    this.carColor,
    this.vehicleYear,
    this.vehicleRegNumber,
  });

  factory DriverProfile.fromJson(json) {
    return DriverProfile(
      carSeat: json["carSeat"] ?? 0,
      carModel: json["carModel"] ?? "",
      carPlate: json["carPlate"] ?? "",
      licenseNumber: json["licenseNumber"] ?? "",
      licenseExpiry: json["licenseExpiry"] != null
          ? DateTime.parse(json["licenseExpiry"])
          : DateTime.now(),
      isVerified: json["isVerified"] ?? false,
      isProfileCompleted: json["isProfileCompleted"] ?? false,
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      country: json["country"] ?? "",
      allTrips: json["allTrips"] ?? 0,
      carColor: json["carColor"] ?? "",
      vehicleYear: json["vehicleYear"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (carSeat != null) {
      data["seat"] = carSeat;
    }
    if (vehicleRegNumber != null && vehicleRegNumber!.isNotEmpty) {
      data["vehicleRegNumber"] = vehicleRegNumber;
    }
    if (carColor != null && carColor!.isNotEmpty) {
      data["carColor"] = carColor;
    }
    if (carModel != null && carModel!.isNotEmpty) {
      data["vehicleModel"] = carModel;
    }
    if (carPlate != null && carPlate!.isNotEmpty) {
      data["licensePlate"] = carPlate;
    }
    if (vehicleYear != null && vehicleYear!.isNotEmpty) {
      data["vehicleYear"] = vehicleYear;
    }

    return data;
  }
}

class LocationModel {
  final double? lat;
  final double? lng;
  final String? address;

  LocationModel({this.lat, this.lng, this.address});

  factory LocationModel.fromJson(json) {
    return LocationModel(
      lat: double.tryParse(json["lat"].toString()) ?? 0.0,
      lng: double.tryParse(json["lng"].toString()) ?? 0.0,
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (lat != null) {
      data["lat"] = lat;
    }
    if (lng != null) {
      data["lng"] = lng;
    }
    if (address != null && address!.isNotEmpty) {
      data["address"] = address;
    }
    return data;
  }

  @override
  String toString() {
    return 'LocationModel(lat: $lat, lng: $lng, address: $address)';
  }
}
