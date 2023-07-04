import 'package:food_delivery/pages/adress/add_address_page.dart';
import 'package:food_delivery/pages/adress/pick_address_map.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_details.dart';
import 'package:food_delivery/pages/food/recommanded_food_details.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address";

  static String getSplash() => "$splashPage";
  static String getSignInPage() => "$signIn";
  static String getInitial() => "$initial";
  static String getAddressPage() => "$addAddress";
  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage() => "$cartPage";
  static String getPickAddressMap() => "$pickAddressMap";

  static List<GetPage> routes = [
    GetPage(
      name: signIn,
      page: () => SignInPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap _pickAddressMap = Get.arguments;
        return _pickAddressMap;
      },
      transition: Transition.fade,
    ),
    GetPage(
      name: addAddress,
      page: () => AddAddressPage(),
      transition: Transition.fade,
    ),

    GetPage(
      name: splashPage,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: initial,
      page: () => HomePage(),
    ),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          var page = Get.parameters["page"];
          return PopularFoodDetails(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          var page = Get.parameters["page"];
          return RecommandedFoodDetails(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    )
  ];
}
