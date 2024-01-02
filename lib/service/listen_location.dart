import 'dart:math';

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({required this.latitude, required this.longitude});
}

class Helper {
  static double calculateDistance(
      Coordinates location1, Coordinates location2) {
    const earthRadius = 6371; // Earth radius in kilometers

    // Convert latitude and longitude from degrees to radians
    double lat1 = degreesToRadians(location1.latitude);
    double lon1 = degreesToRadians(location1.longitude);
    double lat2 = degreesToRadians(location2.latitude);
    double lon2 = degreesToRadians(location2.longitude);

    // Calculate differences in coordinates
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    // Haversine formula to calculate distance
    double a = sin(dlat / 2) * sin(dlat / 2) +
        cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  static bool hasDriverReachedCustomer(
      Coordinates driverLocation, Coordinates customerLocation) {
    double thresholdDistance = 100.000;
    double distance = calculateDistance(driverLocation, customerLocation);
    
    return distance <= thresholdDistance;
  }
}
