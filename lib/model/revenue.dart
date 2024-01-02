class Revenue {
  int id;
  int bookingId;
  int userId;
  String date;
  int driverId;
  double distance;
  int fare;
  String status;

  Revenue({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.date,
    required this.driverId,
    required this.distance,
    required this.fare,
    required this.status,
  });


  factory Revenue.fromJson(Map<String, dynamic> json) {
    return Revenue(
      id: json['id'],
      bookingId: json['booking_id'],
      userId: json['userid'],
      date: json['date'],
      driverId: json['driver_id'],
      distance: json['distance'].toDouble(),
      fare: json['fare'],
      status: json['status'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_id': bookingId,
      'userid': userId,
      'date': date,
      'driver_id': driverId,
      'distance': distance,
      'fare': fare,
      'status': status,
    };
  }
}
