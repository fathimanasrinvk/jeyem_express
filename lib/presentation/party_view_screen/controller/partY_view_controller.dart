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
//   fetchDetailData(String trackNumber, context) async {
//     isLoading = true;
//     notifyListeners();
//     log("PartyViewController -> fetchDetailData()");
//     PartyViewService.fetchDetailData(trackNumber).then((value) {
//       if (value["status"] == "success") {
//         partyViewModel = PartyViewModel.fromJson(value);
//         isLoading = false;
//       } else {
//         AppUtils.oneTimeSnackBar("Unable to fetch Data",
//             context: context, bgColor: ColorTheme.red);
//       }
//       notifyListeners();
//     });
//   }
// }
import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/party_view_screen/model/party_view_model.dart';
import '../../../repository/api/party_view_screen/service/party_view_service.dart';

class PartyViewController extends ChangeNotifier {
  bool isLoading = false;
  PartyViewModel partyViewModel = PartyViewModel();

  Future<void> fetchDetailData(String digits, DateTime fromDate, DateTime toDate, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    log("PartyViewController -> fetchDetailData()");
    PartyViewService.fetchDetailData(digits, fromDate, toDate).then((value){
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

