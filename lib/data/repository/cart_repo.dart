import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo extends GetxService {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    var time=DateTime.now().toString();

    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // sharedPreferences.remove(AppConstants.CART_LIST);
    print(time.toString()+"  ttttttime  shit");
    print(DateTime.now().toString()+"  ttttttime  shit2222");
    cart = [];
    // Convert object to string because sharedpreferences only accept string

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    // cartList.forEach((element) =>cart.add(jsonEncode(element)));
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("From getCartList ${carts.toString()}");
      print(carts.isEmpty.toString());
    }
    List<CartModel> cartList = [];

    // jsonDecode from String to Map(json)

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    // carts.forEach((element) =>cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      // cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      // From String To Json( Decode )
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory=[];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int a = 0; a < cart.length; a++) {
      // print("History list is = ${cart[a]}");
      cartHistory.add(cart[a]);
    }
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("History list is = ${getCartHistoryList().length}");
    removeCart();
    for(int s=0; s<getCartHistoryList().length;s++){
      print("TTTime Of Order is === ${getCartHistoryList()[s].time}");
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
  void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
