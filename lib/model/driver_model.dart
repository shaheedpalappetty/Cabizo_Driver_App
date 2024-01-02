class Driver {
  int? id;
  String name;
  String lastName;
  String phoneNumber;
  String email;
  String birthDate;
  String driverImg;
  String gender;
  String username;
  String password;
  String licenseNumber;
  String experience;

  Driver({
    this.id,
    required this.name,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.birthDate,
    required this.driverImg,
    required this.gender,
    this.username = "",
    this.password = "",
    required this.licenseNumber,
    required this.experience,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
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
      licenseNumber: json['license_number'],
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'birth_date': birthDate,
      'driver_img': driverImg,
      'gender': gender,
      'username': username,
      'password': password,
      'license_number': licenseNumber,
      'experience': experience,
    };
  }
}
