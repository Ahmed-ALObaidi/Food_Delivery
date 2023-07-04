import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for (int a = 0; a < getCartHistoryList.length; a++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[a].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[a].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[a].time!, () => 1);
      }
    }

    print(getCartHistoryList.toString());
    print("########### ${cartItemsPerOrder}");
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    print('${cartItemsPerOrderToList()}');

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    // here I separated the List in to two for loops depending on the time and number of time
    var listCounter = 0;
    Widget timeWidget(index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length){
        DateTime parseDate = DateFormat(
            'yyyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter]
            .time!);
        DateTime inputDate =
        DateTime.parse(parseDate.toString());
        var outputFormat =
        DateFormat('yyyy-MM-dd hh:mm a');
         outputDate =
        outputFormat.format(inputDate);

      }
      return TextWidget(
        text: outputDate,
      );
    }
    print(Get.find<CartController>().getItems.length);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            width: double.maxFinite,
            height: Dimentions.height100,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimentions.height30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(
                  text: 'Your Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                    iconData: Icons.shopping_cart_outlined,
                    iconSize: Dimentions.iconSize25,
                    backGroundColor: AppColors.mainColor,
                    iconColor: Colors.white),
              ],
            ),
          ),
          // Body
          GetBuilder<CartController>(
            builder: (cartController) {
              return cartController.getCartHistoryList().length > 0
                  ? Expanded(
                      child: Container(
                      margin: EdgeInsets.only(
                          top: Dimentions.height20,
                          left: Dimentions.width20,
                          right: Dimentions.width20),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView(
                          children: [
                            for (int a = 0; a < itemsPerOrder.length; a++)
                              Container(
                                height: Dimentions.height130,
                                margin: EdgeInsets.only(
                                    bottom: Dimentions.height20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    // (() {
                                    //   DateTime parseDate = DateFormat(
                                    //           'yyyy-MM-dd HH:mm:ss')
                                    //       .parse(getCartHistoryList[listCounter]
                                    //           .time!);
                                    //   DateTime inputDate =
                                    //       DateTime.parse(parseDate.toString());
                                    //   var outputFormat =
                                    //       DateFormat('yyyy-MM-dd hh:mm a');
                                    //   var outputDate =
                                    //       outputFormat.format(inputDate);
                                    //   return TextWidget(
                                    //     text: outputDate,
                                    //   );
                                    // }()),
                                    SizedBox(
                                      height: Dimentions.height10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[a], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimentions.width5),
                                                    height: Dimentions.height80,
                                                    width: Dimentions.width80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimentions
                                                                    .radius10),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                              AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOAD_URL +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!,
                                                            ))))
                                                : Container();
                                          }),
                                        ),
                                        Container(
                                          height: Dimentions.height80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextWidget(
                                                text: 'Total',
                                                fontSize: Dimentions.font11,
                                                color: AppColors.titleColor,
                                              ),
                                              TextWidget(
                                                text: itemsPerOrder[a] == 1
                                                    ? '${itemsPerOrder[a]} Item'
                                                    : '${itemsPerOrder[a]} Items',
                                                color: AppColors.titleColor,
                                                fontSize: Dimentions.font16,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int s = 0;
                                                      s <
                                                          getCartHistoryList
                                                              .length;
                                                      s++) {
                                                    if (getCartHistoryList[s]
                                                            .time ==
                                                        orderTime[a]) {
                                                      // print("this time ${orderTime[a]}");
                                                      moreOrder.putIfAbsent(
                                                          // jsonDecode convert String to json
                                                          // jsonEncode convert object to String
                                                          getCartHistoryList[s]
                                                              .id!,
                                                          () => CartModel.fromJson(
                                                              jsonDecode(jsonEncode(
                                                                  getCartHistoryList[
                                                                      s]))));
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(
                                                      RouteHelper.cartPage);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimentions.width10,
                                                      vertical:
                                                          Dimentions.height5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimentions.radius5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                  child: TextWidget(
                                                    text: 'One More',
                                                    fontSize: Dimentions.font11,
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ))
                  : Container(height: Dimentions.screenHeight/1.5,
                    child: const NoDataPage(
                        text: 'Your Cart History is Empty !',
                        imgPath: 'assets/image/empty_box.png',
                      ),
                  );
            },
          )
        ],
      ),
    );
  }
}
