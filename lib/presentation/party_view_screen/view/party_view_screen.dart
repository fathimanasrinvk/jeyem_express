import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/utils/app_utils.dart';
import '../../../app_config/app_config.dart';
import '../../../repository/api/party_view_sceen/model/party_view_model.dart';
import '../controller/party-view_controller.dart';
import '../widget/party_view_card.dart';
import '../../../presentation/selection_screen/view/selection_screen.dart';

class PartyViewScreen extends StatelessWidget {
  final String digits;

  PartyViewScreen({required this.digits});

  @override
  Widget build(BuildContext context) {
    final partyViewController = Provider.of<PartyViewController>(context, listen: false);
    partyViewController.fetchPartyUsername();
    var size = MediaQuery.sizeOf(context);

    return Scaffold(

      backgroundColor: ColorTheme.maincolor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change this to your desired color
        ),
        scrolledUnderElevation: 0,
        elevation: 1,
        centerTitle: true,
        title: Text('BOOKING SEARCH', style: GLTextStyles.mainColorTitle1()),
        backgroundColor: ColorTheme.maincolor,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.1), // Add a bottom border
        ),

      ),
      endDrawer: Drawer(


        backgroundColor: ColorTheme.maincolor,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ColorTheme.lightcolor),
              accountName: Text(Provider.of<PartyViewController>(context).ptyUsername, style: GLTextStyles.username()),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcdsC6_g4tHOfg6UsEMCzvW4cqwK6nXUCljg&s'),
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
                    Expanded(
                      child: Text(
                        'Logout',
                        style: GLTextStyles.logout(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout_outlined,
                        size: size.height * 0.03,
                        color: ColorTheme.maincolor,
                      ),
                      onPressed: () => showLogoutConfirmation(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
      body: Padding(
        padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.07, top: size.height * 0.04),
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
                          Provider.of<PartyViewController>(context).fromDate != null
                              ? DateFormat.yMMMMd().format(Provider.of<PartyViewController>(context).fromDate!)
                              : 'Select Date',
                          style: GLTextStyles.date(size: 13),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.06),
                Flexible(
                  child: GestureDetector(
                    onTap: () => fetchDetailData(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.03),
                      decoration: BoxDecoration(
                        color: ColorTheme.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text('Search', style: GLTextStyles.search(size: 13)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Show radio buttons only if there are bookings
            if (Provider.of<PartyViewController>(context).partyViewModel.data != null &&
                Provider.of<PartyViewController>(context).partyViewModel.data!.isNotEmpty &&
                Provider.of<PartyViewController>(context).fromDate != null)
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildRadioButton(value: 'all',
                          groupValue: partyViewController.selectedStatus,
                          label: 'All', onChanged: (value) {
                            partyViewController.setBookingStatus(value);
                          }),
                      _buildRadioButton(value: 'delivered',
                          groupValue: partyViewController.selectedStatus,
                          label: 'Delivered', onChanged: (value) {
                            partyViewController.setBookingStatus(value);
                          }),
                      _buildRadioButton(value: 'non-delivered',
                          groupValue: partyViewController.selectedStatus,
                          label: 'Non-Delivered', onChanged: (value) {
                            partyViewController.setBookingStatus(value);
                          }),
                    ],
                  ),
                ),
              ),
            Consumer<PartyViewController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return Padding(
                    padding: EdgeInsets.only(top: size.height * 0.35),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.grey,
                    ),
                  );
                } else if (controller.partyViewModel.data == null || controller.partyViewModel.data!.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No details available',
                        style: GLTextStyles.mainColorTitle(),
                      ),
                    ),
                  );
                } else {
                  List<Datum> filteredBookings = controller.filterBookings();
                  if (filteredBookings.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          controller.selectedStatus == 'delivered'
                              ? 'No delivered items'
                              : 'No non-delivered items',
                          style: GLTextStyles.mainColorTitle1(),
                        ),
                      ),
                    );
                  } else {
                    return Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * 0.03),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorTheme.white,
                            border: Border.all(color: ColorTheme.maincolor),
                          ),
                          width: size.width * 1.1,
                          child: BookingDetails(
                            size: size,
                            bookingDetails: filteredBookings,
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Provider.of<PartyViewController>(context, listen: false).fromDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        var size = MediaQuery.sizeOf(context);

        return LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:  size.width * 0.4, // Adjust width to prevent overflow
                maxHeight:  size.height * 0.4, // Adjust height if needed
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: ColorTheme.maincolor, // Header background color
                    onPrimary: ColorTheme.white, // Header text color
                    onSurface: ColorTheme.black, // Body text color
                  ),
                  dialogBackgroundColor: ColorTheme.lightcolor, // Background color of the date picker
                ),
                child: child!, // Return the original child wrapped inside the constraints
              ),
            );
          },
        );
      },
    );
    if (picked != null) {
      // Set the selected date
      Provider.of<PartyViewController>(context, listen: false).setFromDate(picked);

      // Call the fetch function immediately after setting the date
      await fetchDetailData(context);
    }
  }

  Future<void> fetchDetailData(BuildContext context) async {
    if (Provider.of<PartyViewController>(context, listen: false).fromDate != null) {
      await Provider.of<PartyViewController>(context, listen: false)
          .fetchDetailData(digits, Provider.of<PartyViewController>(context, listen: false).fromDate!, context);
    } else {
      AppUtils.oneTimeSnackBar("Please select the date", showOnTop: false, context: context, bgColor: ColorTheme.black);
    }
  }

  Future<void> showLogoutConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorTheme.white,
          title: Text(
            'Confirm Logout',
            style: GLTextStyles.cancel(size: 18),
          ),
          content:  Text('Are you sure you want to log out?',style: GLTextStyles.textformfieldhint1(size: 14)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',  style: GLTextStyles.cancel(size: 14)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await storeDigitsAndLogout(context);
              },
              child: Text('Logout', style: GLTextStyles.cancel(size: 14)),
            ),
          ],
        );
      },
    );
  }

  Future<void> storeDigitsAndLogout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(AppConfig.partyDigits, digits);
    await logout(context);
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
}

Widget _buildRadioButton({
  required String value,
  required String groupValue,
  required String label,
  required ValueChanged<String?> onChanged,
}) {
  return Row(
    children: [
      Radio<String>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: ColorTheme.white,


      ),
      Text(label, style: GLTextStyles.poppins2()),
    ],
  );
}
