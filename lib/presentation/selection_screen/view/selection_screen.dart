import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeyem_express_cargo/presentation/party_login_screen/view/party_login_screen.dart';
import '../../../core/constants/colors.dart';
import '../../employee_login_screen/view/emp_login_screen.dart';
import '../../order_tracking_screen/view/track_order_screen.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme.maincolor,

      // backgroundColor: ColorTheme.secondarycolor.withOpacity(0.8),
      // backgroundColor: ColorTheme.black.withOpacity(0.8),
      //   body:Container(
      // height: double.infinity,
      // width: double.infinity,
      // decoration: BoxDecoration(
      // gradient: LinearGradient(
      // colors: [
      // Color(0XFF00DDA8),
      // Color(0xFF9C69E3),
      // Color(0xFF9C69E3),
      // Color(0xFF9C69E3)
      // ],
      // begin: Alignment.topLeft,
      // end: Alignment.bottomRight,
      // ),
      // ),
      //   child:
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Image.asset(
              'assets/logo/JEYEM LOGO nw.png',
              height: size.height * 0.09,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TrackOrderScreen()));
              },
              child: CustomContainer(
                color: Color(0XFFEDAE49),
                image:
                    'assets/selection_icons/track order.png', // Replace with your image URL or asset
                text: 'TRACK ORDER',
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => EmpLoginScreen()));
              },
              child: CustomContainer(
                color: Color(0XFF03dac8),
                image:
                    'assets/selection_icons/Employee login.png', // Replace with your image URL or asset
                text: 'EMPLOYEE LOGIN',
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PartyLoginScreen()));
              },
              child: CustomContainer(
                color: Color(0XFFd52bbb),
                image:
                    'assets/selection_icons/party login.png', // Replace with your image URL or asset
                text: 'PARTY LOGIN',
              ),
            ),
            
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: size.width * 0.17,
            //       right: size.width * 0.17,
            //       top: size.height * 0.075),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(
            //           builder: (context) => TrackOrderScreen()));
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: ColorTheme.black.withOpacity(0.8),
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       height: size.height * .13,
            //       width: size.width * .750,
            //       // width: double.infinity,
            //       // height: size.height * 0.052,
            //       child: Center(
            //         child: Text('TRACK ORDER',
            //             style: GLTextStyles.selectionbuttontext()),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: size.height * .06,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       // top: size.height * 0.024,
            //       left: size.width * 0.17,
            //       right: size.width * 0.17),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(
            //           builder: (context) => EmpLoginScreen()));
            //     },
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: ColorTheme.black.withOpacity(0.8),
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       height: size.height * .13,
            //       width: size.width * .750,
            //       // width: double.infinity,
            //       // height: size.height * 0.052,
            //       child: Center(
            //         child: Text('EMPLOYEE LOGIN',
            //             style: GLTextStyles.selectionbuttontext()),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: size.height * .06,
            // ),

            // Padding(
            //   padding: EdgeInsets.only(
            //       // top: size.height * 0.024,
            //       left: size.width * 0.17,
            //       right: size.width * 0.17),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(
            //           builder: (context) => PartyLoginScreen()));
            //     },
            //     child: Container(
            //       height: size.height * .13,
            //       width: size.width * .750,
            //       decoration: BoxDecoration(
            //         color: ColorTheme.black.withOpacity(0.8),
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       // width: double.infinity,
            //       // height: size.height * 0.052,
            //       child: Center(
            //         child: Text(
            //           'PARTY LOGIN',
            //           style: GLTextStyles.selectionbuttontext(),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: size.height*0.04,),
            // Lottie.asset('assets/animation/truck_delivery.json',height: size.height*0.12 )
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Color color;
  final String image;
  final String text;

  const CustomContainer({
    required this.color,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width * 0.45,
      height: size.height * 0.17,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: size.height * .02,
            child: Container(
              width: size.width * 0.23,
              height: size.height * 0.09,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * .02,
            child: Text(
              text,
              style: GoogleFonts.raleway(
                color: ColorTheme.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
