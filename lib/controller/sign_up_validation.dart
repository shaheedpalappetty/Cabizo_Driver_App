// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/model/document_model.dart';
import 'package:taxi_app/model/driver_model.dart';
import 'package:taxi_app/model/vehicle_model.dart';
import 'package:taxi_app/service/repo.dart';
import 'package:taxi_app/view/document_screen.dart';
import 'package:taxi_app/view/loding_screen.dart';
import 'package:taxi_app/view/vehicle_details.dart';
import 'package:taxi_app/widgets/buttons/autbutton.dart';

SignupController licenseFrontController = SignupController();
SignupController licenseBackController = SignupController();
SignupController adharCardFront = SignupController();
SignupController adharCardBack = SignupController();
SignupController profilePic = SignupController();
SignupController profilePhotoController = SignupController();

ImagePicker imagePicker = ImagePicker();

class SignupController extends GetxController {
  RxInt selectedVehicle = 0.obs;
  List<VehicleSelection> vehicleOptions = [
    VehicleSelection(id: 1, name: 'SUV'),
    VehicleSelection(id: 2, name: 'Hatchback'),
    VehicleSelection(id: 3, name: 'Sedan'),
  ];
  selectingVehicle(int value) {
    selectedVehicle.value = value;
    update();
    selectingVehicleGet(value);
  }

  VehicleSelection? selectedVehicleGet;
  selectingVehicleGet(int value) {
    selectedVehicleGet = vehicleOptions.firstWhere(
        (vehicle) => vehicle.id == value,
        orElse: () => VehicleSelection(id: 0, name: ''));
  }

  GlobalKey<FormState> personalKey = GlobalKey<FormState>();
  GlobalKey<FormState> vehicleKey = GlobalKey<FormState>();
  GlobalKey<FormState> uploadAdharkey = GlobalKey<FormState>();
  GlobalKey<FormState> signinsformKey = GlobalKey<FormState>();

  GlobalKey<FormState> uploadformKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final locationController = TextEditingController();
  final intrestedController = TextEditingController();
  final expController = TextEditingController();
  final langController = TextEditingController();
  final licenseController = TextEditingController();
  //
  final carBrandController = TextEditingController();
  final carModelController = TextEditingController();
  final carYearControllerl = TextEditingController();
  final carColorController = TextEditingController();
  final carSeatController = TextEditingController();
  final carNumberController = TextEditingController();
  //
  final adharNumberController = TextEditingController();
  final adharAddressController = TextEditingController();
  final expiereDateController = TextEditingController();
  final genderController = TextEditingController();
  final birthController = TextEditingController();
  final emailContorllers = TextEditingController();
  final passwordercontroller = TextEditingController();
  var isProfiepathSet = false.obs;
  var profilepicPath = ''.obs;
  var imageUrl = ''.obs;
  RxBool uploaded = false.obs;
  RxBool uploadedAdhr = false.obs;

  RxString selectRepeat = 'None'.obs;
  final List<String> selectRepeatList = [
    'None',
    'Male',
    'Female',
  ];

  createDriver() async {
    final driver = Driver(
        licenseNumber: licenseController.text.trim(),
        name: nameController.text.trim(),
        lastName: lastnameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        email: emailContorllers.text.trim(),
        birthDate: birthController.text.trim(),
        driverImg: profilePic.imageUrl.value,
        gender: genderController.text.trim(),
        experience: expController.text.trim());
    int? id = await Repo.driverPost(driver);
    if (id != null) {
      driver.id = id;
      Get.to(VehicleInfo(
        userId: id,
      ));
    } else {}
  }

  addVehicleDetails(userId) async {
    final vehicle = VehicleDetails(
      userId: userId,
      vehicleBrand: carBrandController.text.trim(),
      vehicleModel: carModelController.text.trim(),
      vehicleYear: carYearControllerl.text.trim(),
      vehicleColor: carColorController.text.trim(),
      vehicleSeat: carSeatController.text.trim(),
      vehicleNumber: carNumberController.text.trim(),
      vehicleType: selectedVehicleGet!.name.trim(),
    );
    bool added = await Repo.addVehicle(vehicle);
    if (added) {
      Get.to(DocumentScreen(id: userId), transition: Transition.cupertino);
    } else {}
  }

  addDriverDocuments(userId) async {
    final documents = Documents(
        userId: userId,
        licenseNo: licenseController.text.trim(),
        licenseExp: expiereDateController.text.trim(),
        licenseFront: licenseFrontController.imageUrl.value,
        licenseBack: licenseBackController.imageUrl.value,
        adharNo: adharNumberController.text.trim(),
        adharAddress: adharAddressController.text.trim(),
        adharFront: adharCardFront.imageUrl.value,
        adharBack: adharCardBack.imageUrl.value);
    final added = await Repo.addDocuments(documents);
    if (added) {
      Get.to(const Lodingpage());
    } else {}
  }

  vehicleScreenValidation(userId) async {
    if (vehicleKey.currentState!.validate()) {
      await addVehicleDetails(userId);
    } else {}
  }

  personalScreenValidation() {
    if (personalKey.currentState!.validate()) {
      personalScreenValidation2();
    } else {}
  }

  personalScreenValidation2() async {
    if (phoneController.text.isNotEmpty &&
        emailContorllers.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        birthController.text.isNotEmpty) {
      await createDriver();
      showTaxiDriverDetailsDialog();
    } else {
      Get.snackbar("Error Message", "Fill all colums",
          backgroundColor: Colors.red);
    }
  }

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  selectGetnder(newvalue) {
    selectRepeat.value = newvalue;
    genderController.text = newvalue;
  }

  getTimeFromUser(BuildContext context) async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2123));

    if (pickerDate != null) {
      selectedDate.value = pickerDate;
      String date = DateFormat.yMd().format(selectedDate.value).toString();
      birthController.text = date;
    } else {}
  }

  uploadAdhrvalidation() {
    if (uploadAdharkey.currentState!.validate()) {
      uploadeAdharFucn();
    }
  }

  uploadButtonPressValidation() {
    if (uploadformKey.currentState!.validate()) {
      uploader();
    }
  }

  uploadeAdharFucn() {
    if (adharCardFront.profilepicPath.value.isNotEmpty ||
        adharCardBack.profilepicPath.value.isNotEmpty) {
      uploadedAdhr.value = true;
      Get.back();
    } else {}
  }

  uploader() {
    if (licenseFrontController.profilepicPath.value.isNotEmpty ||
        licenseBackController.profilepicPath.isNotEmpty) {
      uploaded.value = true;
      Get.back();
    } else {}
  }

  emailvalidation(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Please enter a valid email address";
    } else {
      return null;
    }
  }

  textFeildValidation(String value) {
    if (value.isEmpty) {
      return "Fill the fireld";
    } else {
      return null;
    }
  }

  passwordValidation(String value) {
    if (value.length > 8) {
      return null;
    } else {
      return "please enter 8 characters";
    }
  }

  imagepickerfun() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profilepicPath.value = pickedImage.path;
      isProfiepathSet.value = true;
      imageUrl.value = await getImageUrlfromFirebase(pickedImage.path);
      update();
    } else {
      Get.snackbar(
        'Somthing Error',
        'Add photo its required',
        colorText: const Color.fromARGB(255, 255, 67, 67),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void showTaxiDriverDetailsDialog() {
    Get.defaultDialog(
        title: 'Details Submission',
        content: Text(
          '''\n
         1. Vehicle Details:
          - Provide accurate information about your vehicle.
          - Make sure to include the car's make, model, and registration details.

          2. Vehicle Age Requirement:
          - Your car must be no more than 5 years old.
          - Please verify your vehicle's manufacturing year before submission.

          Additional Notes:
          - Ensure that all provided information is accurate to prevent any discrepancies.
          - Verify the spelling and formatting of all details to avoid any errors or rejections.
          - Once all fields are filled without any errors, you can submit your driver details successfully.
           ''',
          textAlign: TextAlign.center,
          style:
              GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        contentPadding: const EdgeInsets.only(right: 20, left: 10),
        titleStyle: GoogleFonts.urbanist(fontWeight: FontWeight.bold),
        actions: [
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const AutButton(text: 'Done')),
          )
        ]);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getImageUrlfromFirebase(String image) async {
    String? url;
    String uniqueName = DateTime.now().millisecond.toString();
    Reference firebaseRootReference = FirebaseStorage.instance.ref();
    Reference toUploadImgReference =
        firebaseRootReference.child('myPictures$uniqueName.png');
    try {
      await toUploadImgReference.putFile(File(image));
      url = await toUploadImgReference.getDownloadURL();
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }

    return url;
  }
}
