import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimentions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    List<String> signUpImages = ['t.png', 'f.png', 'g.png'];
    void _registration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      if (name.isEmpty) {
        showCustomSnackBar("Type in your name please ", title: "Name");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password please ", title: "Password");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number please ",
            title: "Phone Number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address please ",
            title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address please ",
            title: "Valid Email Address");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can\'t be less than six characters ",
            title: "Password");
      } else {
        showCustomSnackBar("All went well ", title: "Perfect");
        SignUpBodyModel signUpBodyModel = SignUpBodyModel(
            password: password, email: email, phone: phone, name: name);
        authController.registeration(signUpBodyModel).then((status) {
          if (status.isSuccess) {
            print("Success Registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            print("Doesnot Success Registration");
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
              //your Email
              AppTextField(
                  textController: emailController,
                  iconColor: AppColors.yellowColor,
                  hintText: 'Email',
                  prefixIcon: Icons.email),
              SizedBox(
                height: Dimentions.height20,
              ),
              //your Password
              AppTextField(
                  textController: passwordController,
                  iconColor: AppColors.yellowColor,
                  hintText: 'Password',
                  isObscure: true,
                  prefixIcon: Icons.password_sharp),
              SizedBox(
                height: Dimentions.height20,
              ),
              //your Name
              AppTextField(
                  textController: nameController,
                  iconColor: AppColors.yellowColor,
                  hintText: 'Name',
                  prefixIcon: Icons.person),
              SizedBox(
                height: Dimentions.height20,
              ),
              //your Phone
              AppTextField(
                  textController: phoneController,
                  iconColor: AppColors.yellowColor,
                  hintText: 'Phone',
                  prefixIcon: Icons.phone),
              SizedBox(
                height: Dimentions.height45,
              ),
              //Sign UP Button
              GestureDetector(
                onTap: () {
                  _registration(_authController);
                },
                child: Container(
                  width: Dimentions.screenWidth / 2,
                  height: Dimentions.screenHeight / 13,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimentions.height25),
                  ),
                  child: Center(
                      child: TextWidget(
                        text: 'Sign UP',
                        color: Colors.white,
                        fontSize: Dimentions.font26,
                      )),
                ),
              ),
              SizedBox(
                height: Dimentions.height10,
              ),
              //Tag Line
              RichText(
                text: TextSpan(
                    text: 'Have an account already?',
                    style: TextStyle(
                        color: AppColors.paraColor, fontSize: Dimentions.font20),
                    recognizer: TapGestureRecognizer()..onTap = () => Get.back),
              ),
              SizedBox(
                height: Dimentions.height20,
              ),
              //Sign Up options
              RichText(
                text: TextSpan(
                  text: 'Sign Up using one of the following : ',
                  style: TextStyle(
                      color: AppColors.paraColor, fontSize: Dimentions.font16),
                ),
              ),
              Wrap(
                children: List.generate(
                    3,
                        (index) => Padding(
                      padding: EdgeInsets.only(
                          left: Dimentions.width20,
                          right: Dimentions.width20,
                          top: Dimentions.height20),
                      child: CircleAvatar(
                        radius: Dimentions.radius30,
                        backgroundImage:
                        AssetImage('assets/image/' + signUpImages[index]),
                      ),
                    )),
              )
            ],
          ),
        );
      },),
    );
  }
}
