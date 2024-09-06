
import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/party_view_screen/model/party_view_model.dart';
import '../../../repository/api/party_view_screen/service/party_view_service.dart';

class PartyViewController extends ChangeNotifier {
  bool isLoading = false;
  PartyViewModel partyViewModel = PartyViewModel();

  Future<void> fetchDetailData(String digits, DateTime fromDate, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    log("PartyViewController -> fetchDetailData()");
    PartyViewService.fetchDetailData(digits, fromDate).then((value){
      if (value["status"] == "success") {
        partyViewModel = PartyViewModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    });
  }
}

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import '../../../core/constants/colors.dart';
// import '../../../core/utils/app_utils.dart';
// import '../../../repository/api/party_view_screen/model/party_view_model.dart';
// import '../../../repository/api/party_view_screen/service/party_view_service.dart';
//
// class PartyViewController extends ChangeNotifier {
//   bool isLoading = false;
//   PartyViewModel partyViewModel = PartyViewModel();
//
//   Future<void> fetchDetailData(String digits, DateTime fromDate, BuildContext context) async {
//     isLoading = true;
//     notifyListeners();
//     log("PartyViewController -> fetchDetailData()");
//
//     try {
//       final response = await PartyViewService.fetchDetailData(digits, fromDate);
//
//       if (response != null && response["status"] == "success") {
//         partyViewModel = PartyViewModel.fromJson(response);
//       } else if (response != null) {
//         // Handle specific API error response
//         AppUtils.oneTimeSnackBar("Unable to fetch Data: ${response["message"] ?? "Unknown error"}",
//             context: context, bgColor: ColorTheme.red);
//       } else {
//         // Handle null response
//         AppUtils.oneTimeSnackBar("No response from server",
//             context: context, bgColor: ColorTheme.red);
//       }
//     } catch (e) {
//       log('Error in fetchDetailData: $e');
//       AppUtils.oneTimeSnackBar("An error occurred: $e",
//           context: context, bgColor: ColorTheme.red);
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
