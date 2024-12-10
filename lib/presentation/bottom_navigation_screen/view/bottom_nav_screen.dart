import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../controller/bottom_nav_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavBarController(),
      child: Consumer<BottomNavBarController>(
        builder: (context, controller, _) {
          final List<Widget> bottomBarPages = [
            Container(color: Colors.white,),
            Container(color: Colors.white,),
            Container(color: Colors.white,),
          ];

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: bottomBarPages,
            ),
            extendBody: true,
            bottomNavigationBar: AnimatedNotchBottomBar(
              notchBottomBarController: controller.notchController,
              color: ColorTheme.maincolor,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: ColorTheme.lightcolor,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10,color: Colors.grey),
              elevation: 1,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(Icons.home_filled, color: Colors.blueGrey),
                  activeItem: Icon(Icons.home_filled, color: Colors.blueAccent),
                  itemLabel: 'Home',
                ),

                BottomBarItem(
                  inActiveItem: Icon(Icons.settings, color: Colors.blueGrey),
                  activeItem: Icon(Icons.settings, color: Colors.blueAccent),
                  itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Icon(Icons.person, color: Colors.blueGrey),
                  activeItem: Icon(Icons.person, color: Colors.yellow),
                  itemLabel: 'Profile',
                ),
              ],
              onTap: (index) {
                controller.updateSelectedIndex(index);
                controller.pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            ),
          );
        },
      ),
    );
  }
}
