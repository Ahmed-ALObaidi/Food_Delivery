import 'dart:convert';

class AddressModel {
  late int? _id;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _addressType;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      address,
      contactPersonName,
      contactPersonNumber,
      required addressType,
      latitude,
      longitude}) {
    _id = id;
    _address = address;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _addressType = addressType;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;

  String get addressType => _addressType;

  String get latitude => _latitude;

  String get longitude => _longitude;

  String? get contactPersonName => _contactPersonName;

  String? get contactPersonNumber => _contactPersonNumber;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? '';
    _address = json['address'] ?? '';
    _contactPersonName = json['contact_person_name'] ?? '';
    _contactPersonNumber = json['contact_person_number'] ?? '';
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['addressType'] = _addressType;
    data['contactPersonName'] = _contactPersonName;
    data['contactPersonNumber'] = _contactPersonNumber;
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    data['address'] = _address;
    return data;
  }
}
