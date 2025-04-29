import 'package:flutter/material.dart';
import 'package:jeyem_express_cargo/core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/booking_count_screen/service/add_booking_count_screen_service.dart';

class BookingCountProvider extends ChangeNotifier {
  DateTime? selectedDate;
  TextEditingController bookingCountController = TextEditingController();
  TextEditingController boxCountController = TextEditingController();

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> submitCounts(String digits, BuildContext context) async {
    if (selectedDate == null) {
      AppUtils.oneTimeSnackBar("Please select a date", context: context);
      return;
    }

    if (bookingCountController.text.isEmpty || boxCountController.text.isEmpty) {
      AppUtils.oneTimeSnackBar("Please enter both counts", context: context);
      return;
    }

    try {
      final response = await BookingCountService.submitCounts(
        digits,
        selectedDate!,
        bookingCountController.text,
        boxCountController.text,
      );

      if (response != null && response["status"] == 200) {
        AppUtils.oneTimeSnackBar("Counts submitted successfully",
            context: context, bgColor:ColorTheme.maincolor,textStyle: TextStyle(color: ColorTheme.white));
        Navigator.pop(context);
      } else {
        AppUtils.oneTimeSnackBar("Failed to submit counts", context: context);
      }
    } catch (e) {
      AppUtils.oneTimeSnackBar("Error submitting counts", context: context);
    }
  }

  @override
  void dispose() {
    bookingCountController.dispose();
    boxCountController.dispose();
    super.dispose();
  }
}