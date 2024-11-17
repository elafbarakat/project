import 'form_registration.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String fatherName;
  String motherName;
  bool gender;

  DateTime birthDate;
  int cityId;
  String constraint;
  String idNumber;
  String idCardNumber; // vrl f'hrm hgi,dm
  DateTime dateCreate;
  String phone;
  String phoneSecondary;
  String telephone;
  String address;
  String addressDetails;
  FormRegistration form;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fatherName,
    required this.motherName,
    required this.gender,
    required this.birthDate,
    required this.cityId,
    required this.constraint,
    required this.idNumber,
    required this.idCardNumber,
    // required this.personalImagePath,
    // required this.frontCardImagePath,
    // required this.backCardImagePath,
    required this.dateCreate,
    required this.phone,
    required this.phoneSecondary,
    required this.telephone,
    required this.address,
    required this.addressDetails,
    required this.form,
  });
}
