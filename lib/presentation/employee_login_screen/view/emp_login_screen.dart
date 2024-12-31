import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../selection_screen/view/selection_screen.dart';
import '../controller/emplogincontroller.dart';

class EmpLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SelectionScreen()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorTheme.maincolor,
        appBar: AppBar(
          backgroundColor: ColorTheme.maincolor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ColorTheme.white),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SelectionScreen())),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorTheme.maincolor,
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0,
                left: size.width * 0.07,
                right: size.width * 0.07,
                child: Image.asset(
                  'assets/logo/JEYEM LOGO (2).png',
                  height: size.height * 0.09,
                ),
              ),
              Positioned(
                top: size.height * 0.165,
                left: size.width * .09,
                right: size.width * .09,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorTheme.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * .08),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: size.height * .035),
                          Lottie.asset("assets/animation/b.json",
                              height: size.height * 0.09),
                          SizedBox(height: size.height * .02),
                          Text('Employee Login',
                              style: GLTextStyles.poppins2()),
                          SizedBox(height: size.height * .05),
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            style: GLTextStyles.poppins4(size: 13),
                            decoration: InputDecoration(
                              fillColor: ColorTheme.white,
                              filled: true,
                              hintText: 'Enter Username',
                              hintStyle: GLTextStyles.textformfieldhint(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: size.width * .05),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                    color: ColorTheme.white,
                                    width: size.width * .004),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                    color: ColorTheme.secondarycolor,
                                    width: size.width * .004),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * .02),
                          Consumer<LoginController>(
                            builder: (context, controller, _) {
                              return TextFormField(
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                obscureText: controller.visibility,
                                obscuringCharacter: '*',
                                style: GLTextStyles.poppins4(size: 13),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorTheme.white,
                                  hintText: 'Password',
                                  hintStyle: GLTextStyles.textformfieldhint(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: size.width * .05),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                        color: ColorTheme.white,
                                        width: size.width * .004),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: BorderSide(
                                        color: ColorTheme.secondarycolor,
                                        width: size.width * .004),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.onPressed();
                                    },
                                    icon: Icon(
                                      controller.visibility == true
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                onFieldSubmitted: (_) {
                                  // Trigger login when the "Enter" key is pressed
                                  Provider.of<LoginController>(context,
                                          listen: false)
                                      .onLogin(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    context,
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: size.height * .035),
                          GestureDetector(
                            onTap: () {
                              Provider.of<LoginController>(context,
                                      listen: false)
                                  .onLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                context,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorTheme.maincolor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              width: double.infinity,
                              height: size.height * 0.052,
                              child: Center(
                                child: Text('Login',
                                    style: GLTextStyles.poppins2(
                                        size: 13, weight: FontWeight.normal)),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
