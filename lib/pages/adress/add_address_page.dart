import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/models/AddressModel.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/pages/adress/pick_address_map.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = const LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    // if (_isLogged && Get.find<UserController>().userModel == null) {
    //   Get.find<UserController>().getUserInfo();
    // }
    if (_isLogged) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          '') {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('Address Page'), backgroundColor: AppColors.mainColor),
      body: GetBuilder<UserController>(builder: (userController) {
        // if we don't work on the map and have a information in the local storage
        if (
            _contactPersonName.text.isEmpty) {
          // userController.getUserInfo();
          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
            _contactPersonName.text = userController.userModel.name;
            _contactPersonNumber.text = userController.userModel.phone;
          }
        }
        return GetBuilder<LocationController>(
          builder: (locationController) {
            // if we change the UI or if we work on the map
            _addressController.text =
            '${locationController.placemark.name ?? ''}'
                '${locationController.placemark.locality ?? ''}'
                '${locationController.placemark.postalCode ?? ''}'
                '${locationController.placemark.country ?? ''}';
            print('address in my view is = ${_addressController.text}');

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimentions.height225,
                    margin: EdgeInsets.symmetric(
                        vertical: Dimentions.height10,
                        horizontal: Dimentions.width5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.height5),
                        border:
                        Border.all(width: 2, color: AppColors.mainColor)),
                    child: GoogleMap(
                      initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                      onTap: (argument) {
                        Get.toNamed(RouteHelper.getPickAddressMap(),
                            arguments: PickAddressMap(
                              fromAddress: true,
                              fromSignUp: false,
                              googleMapController:
                              locationController.mapController,
                            ));
                      },
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      onCameraIdle: () {
                        locationController.updatePosition(
                            _cameraPosition, true);
                      },
                      onCameraMove: ((position) => _cameraPosition = position),
                      onMapCreated: (GoogleMapController mapController) {
                        locationController
                            .setGoogleMapController(mapController);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimentions.width10, top: Dimentions.height10),
                    child: SizedBox(
                      height: Dimentions.height45,
                      child: ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimentions.width10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimentions.width5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(Dimentions.radius5),
                                  // color: AppColors.mainColor,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5),
                                  ]),
                              child: AppIcon(
                                  iconData: index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                      ? Icons.work
                                      : Icons.location_on,
                                  backGroundColor: Colors.white,
                                  iconColor: index ==
                                      locationController.addressTypeIndex
                                      ? AppColors.mainColor
                                      : Colors.grey[200]!,
                                  iconSize: Dimentions.iconSize25),
                            ),
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimentions.height20),
                    child: TextWidget(
                      text: 'Delivery Address',
                      color: AppColors.mainBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height20,
                  ),
                  AppTextField(
                      textController: _addressController,
                      hintText: 'Your Address',
                      prefixIcon: Icons.map,
                      iconColor: AppColors.mainColor),
                  SizedBox(
                    height: Dimentions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimentions.height20),
                    child: TextWidget(
                      text: 'Your Name',
                      color: AppColors.mainBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height10,
                  ),
                  AppTextField(
                      textController: _contactPersonName,
                      hintText: 'Your Name',
                      prefixIcon: Icons.person,
                      iconColor: AppColors.mainColor),
                  SizedBox(
                    height: Dimentions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimentions.height20),
                    child: TextWidget(
                      text: 'Your Phone',
                      color: AppColors.mainBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: Dimentions.height10,
                  ),
                  AppTextField(
                      textController: _contactPersonNumber,
                      hintText: 'Your Phone',
                      prefixIcon: Icons.phone,
                      iconColor: AppColors.mainColor),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: Dimentions.buttomInDetailPage_Height,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimentions.width20,
                      vertical: Dimentions.height30),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimentions.radius40),
                          topLeft: Radius.circular(Dimentions.radius40))),
                  child: GestureDetector(
                    onTap: () {
                      // print('This is Thw Fuck :: ${Get.find<LocationRepo>().getUserAddress()}');
                      AddressModel addressModel = AddressModel(
                        addressType: locationController.addressTypeList[
                            locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        address: _addressController.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        latitude:
                            locationController.position.latitude.toString(),
                        longitude:
                            locationController.position.longitude.toString(),
                      );
                      locationController
                          .addAddress(addressModel)
                          .then((response) {
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar('Address', 'Added Address Successfully');
                        } else {
                          Get.snackbar('Address',
                              "Address Does\'nt Successfully Added ${response.message}");
                        }
                      });
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Dimentions.width80),
                      padding: EdgeInsets.symmetric(
                          vertical: Dimentions.height10,
                          horizontal: Dimentions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor),
                      child: TextWidget(
                        text: 'Save Address',
                        color: Colors.white,
                        fontSize: Dimentions.font20,
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
