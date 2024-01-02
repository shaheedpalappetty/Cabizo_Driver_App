class VehicleDetails {
  int? detailsId;
  int userId;
  String vehicleBrand;
  String vehicleModel;
  String vehicleYear;
  String vehicleColor;
  String vehicleSeat;
  String vehicleNumber;
  String vehicleType;

  VehicleDetails({
    this.detailsId,
    required this.userId,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.vehicleColor,
    required this.vehicleSeat,
    required this.vehicleNumber,
    required this.vehicleType,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) {
    return VehicleDetails(
      detailsId: json['detils_id'],
      userId: json['user_id'],
      vehicleBrand: json['vehicle_brand'],
      vehicleModel: json['vehicle_model'],
      vehicleYear: json['vehicle_year'],
      vehicleColor: json['vehicle_color'],
      vehicleSeat: json['vehicle_seat'],
      vehicleNumber: json['vehicle_number'],
      vehicleType: json['vehicle_type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detils_id': detailsId,
      'user_id': userId,
      'vehicle_brand': vehicleBrand,
      'vehicle_model': vehicleModel,
      'vehicle_year': vehicleYear,
      'vehicle_color': vehicleColor,
      'vehicle_seat': vehicleSeat,
      'vehicle_number': vehicleNumber,
      'vehicle_type':vehicleType
    };
  }
}
