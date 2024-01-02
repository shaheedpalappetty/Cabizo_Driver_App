class DriverModel {
  final int id;
  final String name;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String birthDate;
  final String driverImg;
  final String gender;
  final String username;
  final String password;

  final int experience;
  final String status;
  final String description;

  DriverModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.birthDate,
    required this.driverImg,
    required this.gender,
    required this.username,
    required this.password,
    required this.experience,
    required this.status,
    required this.description,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      birthDate: json['birth_date'],
      driverImg: json['driver_img'],
      gender: json['gender'],
      username: json['username'],
      password: json['password'],
      experience: int.parse(json['experience']),
      status: json['status'],
      description: json['description'],
    );
  }
}
