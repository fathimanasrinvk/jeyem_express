import 'package:flutter/material.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/booking_count_screen/service/add_booking_count_screen_service.dart';

class ViewCountsController extends ChangeNotifier {
  DateTime? fromDate;
  DateTime? toDate;
  bool isLoading = false;
  bool hasSearched = false;
  List<Map<String, dynamic>>? countsData;

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  Future<void> fetchCounts(String digits, BuildContext context) async {
    if (fromDate == null || toDate == null) {
      AppUtils.oneTimeSnackBar("Please select both dates", context: context);
      return;
    }

    isLoading = true;
    hasSearched = true;
    notifyListeners();

    try {
      final response = await BookingCountService.getCounts(digits, fromDate!, toDate!);
      if (response != null && response["data"] != null) {
        countsData = List<Map<String, dynamic>>.from(response["data"]);
      } else {
        countsData = [];
      }
    } catch (e) {
      countsData = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}