import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class RecommandedFoodDetails extends StatelessWidget {
  int pageId;
  String page;
  RecommandedFoodDetails({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    print('page id = ${pageId}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal),
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: Dimentions.height80,
              //Icons
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                     if(page == 'cartpage'){
                       Get.toNamed(RouteHelper.getCartPage());
                     }else{
                       Get.toNamed(RouteHelper.getInitial());
                     }
                    },
                    child: AppIcon(
                        iconData: Icons.clear, iconSize: Dimentions.iconSize16),
                  ),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if(controller.totalQuantity >= 1)
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
              ),
              //Bottom of Image, title of Text
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(Dimentions.height20),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimentions.height5, bottom: Dimentions.height10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimentions.radius20),
                            topRight: Radius.circular(Dimentions.radius20))),
                    child: Center(
                      child: TextWidget(
                        text: product.name,
                        color: AppColors.mainBlackColor,
                        fontSize: Dimentions.iconSize25,
                      ),
                    ),
                  )),
              expandedHeight: Dimentions.height300,
              pinned: true,
              backgroundColor: AppColors.mainColor,
              //Background Image
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //Body Text
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: Dimentions.height10),
                    child:
                        ExpandableTextWidget(text: product.description),
                  )
                ],
              ),
            )
          ]),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimentions.width50,
                    vertical: Dimentions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap:() {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                        iconData: Icons.remove,
                        iconSize: Dimentions.iconSize25,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    TextWidget(
                      text: '\$ ${product.price} X ${controller.inCartItems}',
                      color: AppColors.mainBlackColor,
                      fontSize: Dimentions.font26,
                    ),
                    GestureDetector(onTap: () {
                      controller.setQuantity(true);
                    },
                      child: AppIcon(
                        iconData: Icons.add,
                        iconSize: Dimentions.iconSize25,
                        backGroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimentions.width20,
                          vertical: Dimentions.height20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimentions.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                   GestureDetector(onTap: () {
                     controller.addItems(product);
                   },child:  Container(
                     padding: EdgeInsets.symmetric(
                         vertical: Dimentions.height10,
                         horizontal: Dimentions.width20),
                     decoration: BoxDecoration(
                         borderRadius:
                         BorderRadius.circular(Dimentions.radius20),
                         color: AppColors.mainColor),
                     child: TextWidget(
                       text: '\$ ${product.price} Add To Card',
                       color: Colors.white,
                       fontSize: Dimentions.font20,
                     ),
                   ),)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
