import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import 'package:jeyem_express_cargo/presentation/party_login_screen/view/party_login_screen.dart';
import 'package:jeyem_express_cargo/presentation/party_view_screen/controller/partY_view_controller.dart';
import 'package:jeyem_express_cargo/presentation/selection_screen/view/selection_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../widget/party_view_card.dart';

class PartyViewScreen extends StatefulWidget {
  final String digits;

  PartyViewScreen({required this.digits});

  @override
  _PartyViewScreenState createState() => _PartyViewScreenState();
}

class _PartyViewScreenState extends State<PartyViewScreen> {
  String ptyUsername = ''; // Add a variable to store the username

  DateTime? fromDate;

  @override
  void initState() {
    super.initState();
    fetchPartyusername();

  }

  Future<void> fetchDetailData() async {
    if (fromDate != null) {
      await Provider.of<PartyViewController>(context, listen: false)
          .fetchDetailData(widget.digits, fromDate!, context);
    } else {
      // Handle case when from date is not selected
      AppUtils.oneTimeSnackBar("Please select the date", context: context, bgColor: ColorTheme.red);
    }
  }

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorTheme.maincolor, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: ColorTheme.lightcolor, // Background color of the date picker
          ),
          child: child!,
        );
      },

    );
    if (picked != null) {
      setState(() {
        fromDate = picked;
      });
    }
  }


  Future<void> fetchPartyusername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ptyUsername = prefs.getString(AppConfig.prtyusername) ?? ''; // Retrieve the username
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text('Booking Search',style: GLTextStyles.mainColorTitle(),),
        backgroundColor: ColorTheme.white,
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: ColorTheme.lightcolor
              ),
              accountName: Text(ptyUsername,style: GLTextStyles.poppins1()),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcdsC6_g4tHOfg6UsEMCzvW4cqwK6nXUCljg&s'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03, top: size.height * 0.02),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorTheme.lightcolor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    SizedBox(width: size.width * 0.05),
                    Expanded( // This will allow the text to use the remaining space
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis, // Optional: This will prevent text from overflowing
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout_outlined,
                        size: size.height * 0.03,
                        color: ColorTheme.maincolor,
                      ),
                      onPressed: showLogoutConfirmation,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.07,top: size.height*0.04),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.05),
                      decoration: BoxDecoration(
                        color: ColorTheme.lightcolor,
                        border: Border.all(color: ColorTheme.maincolor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          fromDate != null ? DateFormat.yMMMMd().format(fromDate!) : 'Select Date',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),
                Flexible(
                  child: GestureDetector(
                    onTap: fetchDetailData,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.03,),
                      decoration: BoxDecoration(
                        color: ColorTheme.maincolor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text('Search', style: TextStyle(color: ColorTheme.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Consumer<PartyViewController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return  Padding(
                    padding:  EdgeInsets.only(top: size.height*0.35),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.grey,
                    ),
                  );
                } else if (controller.partyViewModel.data == null) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No details available',
                        style: GLTextStyles.mainTittle(),
                      ),
                    ),
                  );
                } else {
                  return Flexible(
                    child: Padding(
                      padding:  EdgeInsets.only(top: size.height*0.06,),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorTheme.maincolor),
                        ),
                        width: size.width*1.1,
                        child: BookingDetails(
                          size: size,
                          bookingDetails: controller.partyViewModel.data ?? [],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: ColorTheme.white,
    );
  }

  Future<void> logout(BuildContext context) async {
    final partyviewController = Provider.of<PartyViewController>(context, listen: false);
    partyviewController.clearDetails(); // Clear the data before logging out
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppConfig.token);
    await sharedPreferences.setBool(AppConfig.ptyloggedIn, false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
          (route) => false,
    );
  }

  void showLogoutConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.cabinStyle(size: 18),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:  Text('Cancel',style: TextStyle(color: ColorTheme.maincolor),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                storeDigitsAndLogout(context);
              },
              child:  Text('Logout',style: TextStyle(color: ColorTheme.maincolor)),
            ),
          ],
        );
      },
    );
  }
  Future<void> storeDigitsAndLogout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(AppConfig.partyDigits, widget.digits);
    await logout(context);
  }
}

