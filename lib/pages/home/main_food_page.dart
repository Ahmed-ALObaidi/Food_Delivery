import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void>_loadingResources()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        color: AppColors.mainColor,onRefresh: _loadingResources,
        child:  Column(
        children: [
          // Showing the header of the App
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimentions.headerTopMargin, bottom: Dimentions.headerBottumMargin),
              padding: EdgeInsets.symmetric(horizontal: Dimentions.headerHorizantelPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(text: 'Iraq',fontSize: Dimentions.font32,fontWeight: FontWeight.w400,textAlign: TextAlign.center,),
                      Row(
                        children: [
                          TextWidget(text: 'Baghdad',fontSize: Dimentions.font11,fontWeight: FontWeight.normal,textAlign: TextAlign.center,color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimentions.iconSearchWidth,
                      height: Dimentions.iconSearchHeight,
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimentions.sizedBox_15_height)),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimentions.iconSize25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Showing the body of the App
          Expanded(child: SingleChildScrollView(child: FoodPageBody(),)),
        ],
      ),),
    );
  }
}
