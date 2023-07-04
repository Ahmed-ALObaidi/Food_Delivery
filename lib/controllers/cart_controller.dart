import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  // only for storage or sharedpreferences
  List<CartModel> storageItems = [];

  addItems(ProductModel product, int quantity) {
    print("${quantity}test");
    if (_items.containsKey(product.id!)) {
      var totalQuantity = 0;
      _items.update(product.id!, (value) {
        print("================");
        print(value.quantity.toString());
        print("===============888888888888");
        print(quantity.toString());
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      // WE don't need this Condition because we have a same condition in popular product controller in add Item Function
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          print(
              "The Item is adding to the cart, it's id is = ${product.id} quantity = $quantity name is = ${product.name}");
          _items.forEach((key, value) {
            print("The Quantities is = ${value.quantity}");
          });
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
        print("the length of items is = ${_items.length}");
      } else {
        Get.snackbar(
            "Items Count", "You should at least add one Item in the Card",
            colorText: Colors.white, backgroundColor: AppColors.mainColor);
      }
    }
    cartRepo.addToCartList(getItems);
    print(_items.length.toString()+"   yesssss");

    update();
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    int totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }


  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    print("The Length of Items is = ${storageItems.length.toString()}");
    for (int a = 0; a < storageItems.length; a++) {
      _items.putIfAbsent(storageItems[a].product!.id!, () => storageItems[a]);
    }
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
    print(_items.isEmpty.toString()+"   yesssss");
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int,CartModel> setItems){
    _items={};
    _items=setItems;
  }
  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }
  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }
}
