import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.8,keepPage: true);
  double scaleFactor = 0.8;
  double currentPageValue = 0;
  double height = Dimentions.firstContainer_bodyStack_height;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Dimentions.screenHeight);
    print(Dimentions.screenWidth);
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
      print('VALUE    ${currentPageValue}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  Widget buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var curTrans = height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
      // print('Current Scale ${currScale}');
      // print('Current Trans ${curTrans}');
    } else if (index == currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var curTrans = height * (1 - currScale) / 2;
      // matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
      print('Current Scale 2 ${currScale}');
      print('Current Trans 2 ${curTrans}');
    } else if (index == currentPageValue.floor() - 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var curTrans = height * (1 - currScale) / 2;
      // matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
      print('Current Scale 3 ${currScale}');
      print('Current Trans 3 ${curTrans}');
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
    }
    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index,'home'));
            },
            child: Container(
              height: Dimentions.firstContainer_bodyStack_height,
              margin: EdgeInsets.symmetric(
                  horizontal: Dimentions.firstContainer_bodyStack_margin),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                  image: DecorationImage(
                      image: NetworkImage(
                        '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${popularProduct.img!}',
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.secondContainer_bodyStack_height,
              margin: EdgeInsets.only(
                  left: Dimentions.secondContainer_bodyStack_1, // 25
                  right: Dimentions.secondContainer_bodyStack_1,
                  bottom: Dimentions.secondContainer_bodyStack_2), // 30
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffe8e8e8),
                        offset: Offset(0, 5),
                        blurRadius: 5),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimentions.secondContainer_bodyStack_3, //15
                  right: Dimentions.secondContainer_bodyStack_3, //15
                  top: Dimentions.height15, //15
                ),
                child: AppColumn(
                  text: popularProduct.name!,
                  fontSize: Dimentions.font26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Body Slider
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return popularProducts.isLoading
                ? Container(
                    height: Dimentions.mainBodyContainer,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, index) {
                        return buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      },
                    ),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
        //Dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty
                  ? 1
                  : popularProducts.popularProductList.length,
              position: currentPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: Size(
                    Dimentions.sizedBox_4_width, Dimentions.sizedBox_10_height),
                activeColor: AppColors.mainColor,
                activeShape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimentions.sizedBox_5_height)),
              ),
            );
          },
        ),
        //Popular Text
        SizedBox(
          height: Dimentions.sizedBox_30_height,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  child: TextWidget(
                      text: 'Recommended',
                      color: AppColors.mainBlackColor,
                      fontSize: Dimentions.font20)),
              SizedBox(
                width: Dimentions.sizedBox_10_width,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: TextWidget(
                    text: '.',
                    color: Colors.black26,
                  )),
              SizedBox(
                width: Dimentions.sizedBox_10_width,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: TextWidget(
                    text: 'Food Pairing',
                    color: AppColors.textColor,
                    fontSize: Dimentions.font12,
                  )),
            ],
          ),
        ),
        //List of Food and Images Recommended Food
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(RouteHelper.getRecommendedFood(index,'home')),
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      bottom: Dimentions.height10),
                  child: Row(
                    children: [
                      //Image Section
                      Container(
                        height: Dimentions.listViewIMG_Height,
                        width: Dimentions.listViewIMG_Width,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius:
                            BorderRadius.circular(Dimentions.radius20),
                            image: DecorationImage(
                                image: NetworkImage(
                                  '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${recommendedProduct.recommendedProductList[index].img!}',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      //Text Section
                      Expanded(
                          child: Container(
                            height: Dimentions.listViewtxt_Height,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(Dimentions.radius20),
                                    // topLeft: Radius.circular(Dimentions.radius10),
                                    // bottomLeft: Radius.circular(Dimentions.radius10),
                                    topRight: Radius.circular(Dimentions.radius20))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimentions.width10, right: Dimentions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    text: recommendedProduct.recommendedProductList[index].name!,
                                    fontSize: Dimentions.font16,
                                    color: AppColors.mainBlackColor,
                                  ),
                                  TextWidget(
                                    text: 'With Chinese Characteristics ',
                                    fontSize: Dimentions.font12,
                                    color: AppColors.textColor,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(
                                          iconData: Icons.circle_sharp,
                                          text: 'Normal',
                                          textColor: AppColors.textColor,
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(
                                          iconData: Icons.location_on,
                                          text: '1.7km',
                                          textColor: AppColors.textColor,
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(
                                          iconData: Icons.access_time_rounded,
                                          text: '35 min',
                                          textColor: AppColors.textColor,
                                          iconColor: AppColors.iconColor2),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        },)
      ],
    );
  }
}
