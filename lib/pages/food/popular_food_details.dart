import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/text_widget.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetails({Key? key, required this.pageId,required this.page,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
    Get
        .find<PopularProductController>()
        .popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    print('product id = $pageId');
    print('product name is = ${product.name}');
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image section
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: Dimentions.foodIMG_Height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            AppConstants.BASE_URL +
                                AppConstants.UPLOAD_URL +
                                product.img,
                          ),
                          fit: BoxFit.cover)),
                )),
            //icon widget section
            Positioned(
                top: Dimentions.height45,
                left: Dimentions.width20,
                right: Dimentions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(page=='cartpage'){
                          Get.toNamed(RouteHelper.getCartPage());
                        }else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(
                          iconData: Icons.arrow_back_ios,
                          iconSize: Dimentions.iconSize16),
                    ),
                    GetBuilder<PopularProductController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            // if(controller.totalQuantity >= 1)
                            Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: Stack(
                            children: [
                              AppIcon(
                                  iconData: Icons.shopping_cart_outlined,
                                  iconSize: Dimentions.iconSize16),

                                  controller.totalQuantity >= 1 ? Positioned(
                                    top:0,right:0,
                                    child: AppIcon(
                                iconData: Icons.circle,
                                iconSize: Dimentions.iconSize16,size: Dimentions.iconSize16,
                                backGroundColor: AppColors.mainColor,iconColor: Colors.transparent,),
                                  ):Container(),

                              controller.totalQuantity >= 1 ? Positioned(
                                top:-2,right:4,
                                child:
                                TextWidget(text: controller.totalQuantity.toString(),fontSize: Dimentions.font11,color: Colors.white,)
                              ):Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )),
            //introduction of food section
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimentions.foodIMG_Height - Dimentions.height20,
              child: Container(
                  padding: EdgeInsets.only(
                    top: Dimentions.width20,
                    left: Dimentions.width20,
                    right: Dimentions.width20,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimentions.radius20),
                          topRight: Radius.circular(Dimentions.radius20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                          text: product.name, fontSize: Dimentions.font26),
                      SizedBox(
                        height: Dimentions.sizedBox_20_height,
                      ),
                      TextWidget(
                        text: 'Introduction',
                        fontSize: Dimentions.font20,
                        color: AppColors.mainBlackColor,
                      ),
                      SizedBox(
                        height: Dimentions.sizedBox_15_height,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                                  text: product.description!))),
                    ],
                  )),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
              height: Dimentions.buttomInDetailPage_Height,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20,
                  vertical: Dimentions.height30),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimentions.radius40),
                      topLeft: Radius.circular(Dimentions.radius40))),
              child: Row(
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
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        Container(
                          child: TextWidget(
                            text: popularProduct.inCartItems.toString(),
                          ),
                        ),
                        SizedBox(
                          width: Dimentions.width5,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(onTap: () {
                    popularProduct.addItems(product);

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
                        text: '\$ ${product.price} Add To Card',
                        fontSize: Dimentions.font20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
