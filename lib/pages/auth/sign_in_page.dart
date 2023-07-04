import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    void _login(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      if (password.isEmpty) {
        showCustomSnackBar("Type in your password please ", title: "Password");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your Email Address please ",
            title: "Email Address");
      }
      else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid Email Address please ",
            title: "Valid Email Address");
      }
      else if (password.length < 6) {
        showCustomSnackBar("Password can't be less than six characters ",
            title: "Password");
      } else {
        showCustomSnackBar("All went well ", title: "Perfect");

        authController.login(email,password).then((status) {
          if (status.isSuccess) {
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getCartPage());
          } else {
            print("Doesn't Success Registration");
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return _authController.isLoading?CustomLoader():SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimentions.height45,
              ),
              //app Logo
              Container(
                height: Dimentions.height150,
                child: Center(
                  child: CircleAvatar(
                      radius: Dimentions.height80,
                      backgroundColor: Colors.white,
                      backgroundImage:
                      AssetImage('assets/image/logo part 1.png')),
                ),
              ),
              //welcome
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimentions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'HELLO',
                      color: Colors.black,
                      fontSize: Dimentions.font70,
                      fontWeight: FontWeight.bold,
                    ),
                    TextWidget(
                      text: 'Sign into your account',
                      color: AppColors.paraColor,
                      fontSize: Dimentions.font16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimentions.height45,
              ),
              //your Phone
              AppTextField(
                  textController: emailController,
                  iconColor: AppColors.mainColor,
                  hintText: 'Email',
                  prefixIcon: Icons.email),
              SizedBox(
                height: Dimentions.height20,
              ),
              //your Password
              AppTextField(
                  textController: passwordController,
                  iconColor: AppColors.mainColor,
                  hintText: 'Password',
                  isObscure: true,
                  prefixIcon: Icons.password_sharp),
              SizedBox(
                height: Dimentions.height20,
              ),

              //Tag Line
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimentions.width10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Sign into your account',
                        style: TextStyle(
                            color: AppColors.paraColor,
                            fontSize: Dimentions.font16),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimentions.height45,
              ),
              //Sign In Button
              GestureDetector(onTap: () {
                _login(_authController);
              },
                child: Center(
                  child: Container(
                    width: Dimentions.screenWidth / 2,
                    height: Dimentions.screenHeight / 13,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimentions.height25),
                    ),
                    child: Center(
                        child: TextWidget(
                          text: 'Sign IN',
                          color: Colors.white,
                          fontSize: Dimentions.font26,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: Dimentions.height45,
              ),

              //Sign Up options
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                        color: AppColors.paraColor, fontSize: Dimentions.font16),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignUpPage(),transition: Transition.fade),
                        text: ' Create',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: Dimentions.font16),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },),
    );
  }
}
