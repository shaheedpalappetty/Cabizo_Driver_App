class Documents {
  int ? documentId;
  int userId;
  String licenseNo;
  String licenseExp;
  String licenseFront;
  String licenseBack;
  String adharNo;
  String adharAddress;
  String adharFront;
  String adharBack;

  Documents({
     this.documentId,
    required this.userId,
    required this.licenseNo,
    required this.licenseExp,
    required this.licenseFront,
    required this.licenseBack,
    required this.adharNo,
    required this.adharAddress,
    required this.adharFront,
    required this.adharBack,
  });

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      documentId: json['document_id'],
      userId: json['user_id'],
      licenseNo: json['license_no'],
      licenseExp: json['license_exp'],
      licenseFront: json['licence_ft_img'],
      licenseBack: json['licence_bk_img'],
      adharNo: json['adhar_no'],
      adharAddress: json['ahdhar_address'],
      adharFront: json['Adhar_ft_img'],
      adharBack: json['Adhar_bk_img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_id': documentId,
      'user_id': userId,
      'license_no': licenseNo,
      'license_exp': licenseExp,
      'licence_ft_img': licenseFront,
      'licence_bk_img': licenseBack,
      'adhar_no': adharNo,
      'ahdhar_address': adharAddress,
      'Adhar_ft_img': adharFront,
      'Adhar_bk_img': adharBack,
    };
  }
}