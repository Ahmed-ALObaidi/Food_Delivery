import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print('User Has Logged in');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: TextWidget(
          text: 'Profile',
          fontSize: Dimentions.font26,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
              ? Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimentions.height20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //profile Icone
                AppIcon(
                  iconData: Icons.person,
                  iconSize: Dimentions.iconSize100,
                  size: Dimentions.height150,
                  backGroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                ),
                SizedBox(
                  height: Dimentions.height25,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //name
                        AccountWidget(
                            appIcon: AppIcon(
                              iconData: Icons.person,
                              iconSize: Dimentions.iconSize30,
                              size: Dimentions.height45,
                              backGroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                            ),
                            textWidget: TextWidget(
                              text: userController.userModel.name,
                              fontSize: Dimentions.font20,
                              color: AppColors.mainBlackColor,
                            )),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                        //phone
                        AccountWidget(
                            appIcon: AppIcon(
                              iconData: Icons.phone,
                              iconSize: Dimentions.iconSize30,
                              size: Dimentions.height45,
                              backGroundColor: Colors.green,
                              iconColor: Colors.white,
                            ),
                            textWidget: TextWidget(
                              text: userController.userModel.phone,
                              fontSize: Dimentions.font20,
                              color: AppColors.mainBlackColor,
                            )),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                        //email
                        AccountWidget(
                            appIcon: AppIcon(
                              iconData: Icons.email,
                              iconSize: Dimentions.iconSize30,
                              size: Dimentions.height45,
                              backGroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                            ),
                            textWidget: TextWidget(
                              text: userController.userModel.email,
                              fontSize: Dimentions.font20,
                              color: AppColors.mainBlackColor,
                            )),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                        //address
                        GetBuilder<LocationController>(
                          builder: (locationController) {
                            if (_userLoggedIn &&
                                locationController
                                    .addressList.isEmpty) {
                              return GestureDetector(
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      iconData: Icons.location_on,
                                      iconSize: Dimentions.iconSize30,
                                      size: Dimentions.height45,
                                      backGroundColor:
                                      Colors.blueAccent,
                                      iconColor: Colors.white,
                                    ),
                                    textWidget: TextWidget(
                                      text: 'Fill in Your Address',
                                      fontSize: Dimentions.font20,
                                      color: AppColors.mainBlackColor,
                                    )),
                                onTap: () {
                                  Get.toNamed(RouteHelper.getAddressPage());
                                },
                              );
                            }else{
                              return AccountWidget(
                                  appIcon: AppIcon(
                                    iconData: Icons.location_on,
                                    iconSize: Dimentions.iconSize30,
                                    size: Dimentions.height45,
                                    backGroundColor: Colors.blueAccent,
                                    iconColor: Colors.white,
                                  ),
                                  textWidget: TextWidget(
                                    text: 'Your Address',
                                    fontSize: Dimentions.font20,
                                    color: AppColors.mainBlackColor,
                                  ));
                            }
                          },
                        ),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                        //messages
                        AccountWidget(
                            appIcon: AppIcon(
                              iconData: Icons.message_outlined,
                              iconSize: Dimentions.iconSize30,
                              size: Dimentions.height45,
                              backGroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                            ),
                            textWidget: TextWidget(
                              text: 'Messages',
                              fontSize: Dimentions.font20,
                              color: AppColors.mainBlackColor,
                            )),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (Get.find<AuthController>()
                                .userLoggedIn()) {
                              Get.find<LocationController>().clearAddressList();
                              Get.find<AuthController>()
                                  .clearSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>()
                                  .clearCartHistory();
                              Get.offNamed(
                                  RouteHelper.getSignInPage());
                            } else {
                              print("You Loged Out");
                            }
                          },
                          child: AccountWidget(
                              appIcon: AppIcon(
                                iconData: Icons.logout,
                                iconSize: Dimentions.iconSize30,
                                size: Dimentions.height45,
                                backGroundColor:
                                Colors.lightBlueAccent,
                                iconColor: Colors.white,
                              ),
                              textWidget: TextWidget(
                                text: 'Log Out',
                                fontSize: Dimentions.font20,
                                color: AppColors.mainBlackColor,
                              )),
                        ),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                        SizedBox(
                          height: Dimentions.height15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
              : CustomLoader())
              : Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/image/signintocontinue.png'))),
                    height: Dimentions.height100,
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimentions.width20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                      ),
                      height: Dimentions.height100,
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimentions.width20),
                      child: Center(
                          child: TextWidget(
                            text: 'Sign In',
                            color: Colors.white,
                            fontSize: Dimentions.font32,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
