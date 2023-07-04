import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  int _quantity = 0;
  bool _isLoading = false;
  int _inCartItems = 0;
  late CartController _cart;
  int get inCartItems => _inCartItems+_quantity;
  int get quantity => _quantity;

  bool get isLoading => _isLoading;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print('Success');
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoading = true;
      update();
    } else {
      print(response.statusText.toString());
      print(response.statusCode.toString());
      print("Doesn't Success");
      print(response.statusCode.toString());
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print(_quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems+quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems+quantity) > 20) {
      Get.snackbar("Item count", "You can't add more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart=cart;
    bool exist=false;
    exist=_cart.existInCart(product);
    print("Exist of Not = $exist");
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity in cart is = $_inCartItems");
    // update();
  }


  void addItems(ProductModel product){
    // if(_quantity>0){
    print(_quantity);
      _cart.addItems(product, _quantity);
      _quantity=0;
      _inCartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("id = ${value.id} and quantity is = ${value.quantity}");
      });
    // }else{
    //   Get.snackbar("Items Count",
    //       "You should at least add one Item in the Card",
    //       colorText: Colors.white, backgroundColor: AppColors.mainColor);
    // }
    update();
  }

  int get totalQuantity{
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
