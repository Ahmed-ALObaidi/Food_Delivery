import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/AddressModel.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList = [];

  List<AddressModel> get allAddressList => _allAddressList;
  List<String> _addressTypeList = ['home', 'office', 'others'];

  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;

  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;

  Position get position => _position;

  Placemark get placemark => _placemark;

  Placemark get pickPlacemark => _pickPlacemark;

  Position get pickPosition => _pickPosition;

  // For  Service Zone
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Whether the user is in the service zone or not
  bool _inZone = false;

  bool get inZone => _inZone;

  // this is used if the button is showen or hidden whether the map is load
  bool _buttonDisabled = true;

  bool get buttonDisabled => _buttonDisabled;

  void setGoogleMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }

        final ResponseModel responseModel;
        responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(), false);
        // if the button is false we are in the service area
        _buttonDisabled = !responseModel.isSuccess;

        if (_changeAddress) {
          String _address = await getAddressFromGeoCode(
              LatLng(position.target.latitude, position.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print('The Errorrrrr is = ${e}');
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeoCode(LatLng latLng) async {
    String _position = 'Unknown Position Found';
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    if (response.body['status'] == 'OK') {
      _position = response.body['results'][0]['formatted_address'].toString();
      print('The address from geocode = ${_position}');
    } else {
      print('Error Getting GooGle API');
      print('${response.body}');
    }
    update();
    return _position;
  }

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    // To converting to a map should using jasonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    print('This is the Fucking Shit :: ${locationRepo.getUserAddress()}');
    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print('This is Error in User Address');
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAllAddress();
      String _message = response.body['message'];
      responseModel = ResponseModel(true, _message);
      await saveUserAddress(addressModel);
    } else {
      print('Couldn\'t Save the User Address');
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAllAddress() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async{
    late ResponseModel responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if(response.statusCode == 200){
      // if(response.body['zone_id']!=2){
      //   responseModel=ResponseModel(false, response.body['zone_id'].toString());
      //   _inZone=false;
      // }else{
      //   responseModel=ResponseModel(true, response.body['zone_id'].toString());
      //   _inZone=true;
      // }
      _inZone=true;
      responseModel=ResponseModel(true, response.body['zone_id'].toString());
    }else{
      _inZone=false;
      responseModel=ResponseModel(false, response.statusText!.toString());
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    update();
    return responseModel;
  }
}
