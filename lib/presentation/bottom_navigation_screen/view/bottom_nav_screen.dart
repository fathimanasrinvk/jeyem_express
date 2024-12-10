import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import '../../order_tracking_screen/view/track_order_screen.dart';
import '../controller/bottom_nav_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavBarController(),
      child: Consumer<BottomNavBarController>(
        builder: (context, controller, _) {
          final List<Widget> bottomBarPages = [
            Container(color: Colors.white), // Home Screen
            TrackOrderScreen(), // Order Tracking Screen
            Container(color: Colors.white), // Profile Screen
          ];

          return Scaffold(
            body: bottomBarPages[controller.selectedIndex],
            bottomNavigationBar: FlashyTabBar(
              animationCurve: Curves.linear,
              selectedIndex: controller.selectedIndex,
              iconSize: 30,
              showElevation: true,
              onItemSelected: (index) {
                controller.updateSelectedIndex(index);
              },
              items: [
                FlashyTabBarItem(
                  icon: Icon(Icons.home_filled,color: ColorTheme.maincolor,),
                  title: Text('Home',style: TextStyle(color: ColorTheme.maincolor),),
                ),
                FlashyTabBarItem(
                  icon: Icon(Icons.track_changes,color: ColorTheme.maincolor,),
                  title: Text('Track Order',style: TextStyle(color: ColorTheme.maincolor)),
                ),
                FlashyTabBarItem(
                  icon: Icon(Icons.person,color: ColorTheme.maincolor,),
                  title: Text('Profile',style: TextStyle(color: ColorTheme.maincolor)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
