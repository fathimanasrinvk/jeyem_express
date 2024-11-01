import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/core/constants/text_styles.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../selection_screen/view/selection_screen.dart';
import '../controller/emp_login_controller.dart';

class EmpLoginScreen extends StatefulWidget {
  @override
  _EmpLoginScreenState createState() => _EmpLoginScreenState();
}

class _EmpLoginScreenState extends State<EmpLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SelectionScreen()));
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorTheme.maincolor,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color(0XFF00DDA8),
          //       Color(0xFF9C69E3),
          //       Color(0xFF9C69E3),
          //       Color(0xFF9C69E3)
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          // ),
          child: Stack(
            children: [
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: IconButton(
              //     icon: Icon(Icons.arrow_back, color: ColorTheme.black),
              //     onPressed: () {
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //           builder: (context) => SelectionScreen()));
              //     },
              //   ),
              // ),
              Positioned(
                  top: size.height * 0.09,
                  left: size.width * 0.07,
                  right: size.width * 0.07,
                  child: Image.asset(
                    'assets/logo/JEYEM LOGO (2).png',
                    height: size.height*0.09,
                  )),
              Positioned(
                top: size.height * 0.25,
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
                            style: TextStyle(color: ColorTheme.secondarycolor),
                            decoration: InputDecoration(
                              fillColor: ColorTheme.white,
                              filled: true,
                              hintText: 'Enter Username',
                              hintStyle: TextStyle(color: ColorTheme.black),
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
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              obscureText: controller.visibility,
                              obscuringCharacter: '*',
                              style:
                                  TextStyle(color: ColorTheme.secondarycolor),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorTheme.white,
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(color: ColorTheme.black),
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
                                  icon: Icon(controller.visibility == true
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: size.height * .035),
                          GestureDetector(
                            onTap: () {
                              Provider.of<LoginController>(context,
                                      listen: false)
                                  .onLogin(emailController.text.trim(),
                                      passwordController.text.trim(), context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorTheme.maincolor,
                                // color: ColorTheme.secondarycolor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              width: double.infinity,
                              height: size.height * 0.052,
                              child: Center(
                                child: Text('Login',
                                    style: TextStyle(color: ColorTheme.white)),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.1)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
