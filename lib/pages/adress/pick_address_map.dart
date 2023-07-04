import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_button.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.maxFinite,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      },
                    ),
                    Center(
                      child: !locationController.loading
                          ? Image.asset(
                              'assets/image/pick_marker.png',
                              height: Dimentions.height45,
                              width: Dimentions.width50,
                            )
                          : CircularProgressIndicator(),
                    ),
                    Positioned(
                      top: Dimentions.height45,
                      right: Dimentions.width20,
                      left: Dimentions.width20,
                      child: Container(
                        height: Dimentions.height45,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimentions.radius10)),
                        child: Row(
                          children: [
                            AppIcon(
                              iconData: Icons.location_on,
                              iconSize: Dimentions.iconSize16,
                              backGroundColor: AppColors.mainColor,
                              iconColor: Colors.yellowAccent,
                            ),
                            Expanded(
                                child: TextWidget(
                              text:
                                  '${locationController.pickPlacemark.name ?? ''}',
                              color: Colors.white,
                              fontSize: Dimentions.font16,
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: Dimentions.height300*2.1,
                      bottom: Dimentions.height45,
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      child: CustomButton(
                        buttonText: 'Pick Address',onPressed: locationController.loading?null:(){
                          if(locationController.pickPosition.latitude!=0&&locationController.pickPlacemark.name!=null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                print('Test');
                              }
                            }
                          }
                      },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
