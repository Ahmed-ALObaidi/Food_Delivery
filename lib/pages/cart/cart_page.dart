import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Header
          Positioned(
              top: Dimentions.height60,
              right: Dimentions.width20,
              left: Dimentions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    iconData: Icons.arrow_back_ios,
                    iconSize: Dimentions.iconSize34,
                    backGroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimentions.iconSize40,
                  ),
                  SizedBox(
                    width: Dimentions.width100,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      iconData: Icons.home_outlined,
                      iconSize: Dimentions.iconSize34,
                      backGroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      size: Dimentions.iconSize40,
                    ),
                  ),
                  AppIcon(
                    iconData: Icons.shopping_cart_outlined,
                    iconSize: Dimentions.iconSize34,
                    backGroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    size: Dimentions.iconSize40,
                  ),
                ],
              )),
          // Body
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getItems.length>0?Positioned(
                top: Dimentions.height100,
                left: Dimentions.width20,
                right: Dimentions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimentions.height15),
                  // color: Colors.red,
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(
                        builder: (cartController) {
                          var _cartList = cartController.getItems;
                          return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                // color: Colors.green,
                                margin:
                                EdgeInsets.only(bottom: Dimentions.height10),
                                height: Dimentions.height100,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                        Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(
                                            _cartList[index].product!);
                                        var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(
                                            _cartList[index].product!);
                                        if(popularIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,'cartpage'));
                                        }else if (recommendedIndex>=0){

                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,'cartpage'));
                                        }else{
                                          Get.snackbar(
                                              "Product History", "Product review is not available for History product !",
                                              colorText: Colors.white, backgroundColor: Colors.redAccent);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                Dimentions.radius20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL +
                                                        AppConstants.UPLOAD_URL +
                                                        _cartList[index].img!),
                                                fit: BoxFit.cover)),
                                        width: Dimentions.height100,
                                        height: Dimentions.height100,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimentions.width10,
                                    ),
                                    Expanded(
                                        child: Container(
                                          height: Dimentions.height100,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextWidget(
                                                text: _cartList[index].name!,
                                                color: AppColors.mainBlackColor,
                                                fontSize: Dimentions.font16,
                                              ),
                                              TextWidget(
                                                text: 'spicy',
                                                color: AppColors.paraColor,
                                                fontSize: Dimentions.font11,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextWidget(
                                                    text:
                                                    '\$ ${_cartList[index].price}',
                                                    color: Colors.redAccent,
                                                    fontSize: Dimentions.font16,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: Dimentions.width10,
                                                        right: Dimentions.width10,
                                                        bottom: Dimentions.height10,
                                                        top: Dimentions.height10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            Dimentions.radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItems(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color:
                                                            AppColors.signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimentions.width5,
                                                        ),
                                                        Container(
                                                          child: TextWidget(
                                                            text: _cartList[index]
                                                                .quantity
                                                                .toString(), // popularProduct.inCartItems.toString(),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimentions.width5,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController.addItems(
                                                                _cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color:
                                                            AppColors.signColor,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )),
                )):NoDataPage(text: "Your Card is Empty !");
          },)
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimentions.buttomInDetailPage_Height,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20,
                  vertical: Dimentions.height30),
              decoration: BoxDecoration(
                  color: cartController.getItems.length>0?AppColors.buttonBackgroundColor:Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimentions.radius40),
                      topLeft: Radius.circular(Dimentions.radius40))),
              child: cartController.getItems.length>0?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimentions.width20,
                        right: Dimentions.width20,
                        bottom: Dimentions.height20,
                        top: Dimentions.height10),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimentions.radius20),
                        color: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        Container(
                          child: TextWidget(
                            text: "\$ ${cartController.totalAmount.toString()}",
                          ),
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(onTap: () {
                    // popularProduct.addItems(product);
                    if(Get.find<AuthController>().userLoggedIn()){
                      Get.find<UserController>().getUserInfo();
                      print("Tapped");
                      // cartController.addToHistory();
                      if(Get.find<LocationController>().addressList.isEmpty){
                        Get.find<UserController>().getUserInfo();
                        Get.toNamed(RouteHelper.getAddressPage());
                      }else{
                        Get.find<UserController>().getUserInfo();
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    }else{
                      Get.toNamed(RouteHelper.getSignInPage());
                    }

                  },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                          bottom: Dimentions.height20,
                          top: Dimentions.height10),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor),
                      child: TextWidget(
                        text: 'Check Out',
                        fontSize: Dimentions.font20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ):Container(),
            );
          },
        ));


  }
}
