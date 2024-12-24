import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/party_view_sceen/model/party_view_model.dart';
import '../../../repository/api/party_view_sceen/service/party_view_service.dart';



  // Future<void> fetchDetailData(String digits, DateTime fromDate, BuildContext context)async{
  //   isLoading = true;
  //   notifyListeners();
  //   log("PartyViewController -> fetchDetailData()");
  //   PartyViewService.fetchDetailData(digits, fromDate).then((value){
  //     if (value["status"] == "success") {
  //       partyViewModel = PartyViewModel.fromJson(value);
  //       isLoading = false;
  //     } else {
  //       AppUtils.oneTimeSnackBar("Unable to fetch Data",
  //           context: context, bgColor: ColorTheme.red);
  //     }
  //     notifyListeners();
  //   });
  // }


class PartyViewController extends ChangeNotifier {
  bool isLoading = false;
  PartyViewModel partyViewModel = PartyViewModel();
  DateTime? fromDate;
  String ptyUsername = '';
  String selectedStatus = 'all'; // New variable for the selected radio button

  Future<void> fetchDetailData(String digits, DateTime fromDate, BuildContext context) async {
    isLoading = true;
    selectedStatus = 'all';
    notifyListeners();
    log("PartyViewController -> fetchDetailData()");
    PartyViewService.fetchDetailData(digits, fromDate).then((value) {
      if (value != null && value["status"] == "success") {
        partyViewModel = PartyViewModel.fromJson(value);
        isLoading = false;
      } else {
        clearDetails();
        AppUtils.oneTimeSnackBar("No Bookings Found", context: context, bgColor: ColorTheme.lightcolor);
      }
      notifyListeners();
    });
  }

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setBookingStatus(String? status) {
    selectedStatus = status ?? 'all';
    notifyListeners();
  }

  void clearDetails() {
    partyViewModel = PartyViewModel();
    fromDate = null;
    selectedStatus = 'all'; // Reset the status to 'all'
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPartyUsername() async {
    final prefs = await SharedPreferences.getInstance();
    ptyUsername = prefs.getString(AppConfig.prtyusername) ?? '';
    notifyListeners();
  }

  List<Datum> filterBookings() {
    if (selectedStatus == 'all') {
      return partyViewModel.data ?? [];
    } else if (selectedStatus == 'delivered') {
      return partyViewModel.data?.where((item) => item.bookingStatus == 'DELIVERED').toList() ?? [];
    } else {
      return partyViewModel.data?.where((item) => item.bookingStatus != 'DELIVERED').toList() ?? [];
    }
  }
}
