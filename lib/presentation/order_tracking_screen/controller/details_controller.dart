import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/common/model/details_model.dart';
import '../../../repository/api/common/service/serviceeee.dart';


class DetailsController extends ChangeNotifier {
  bool isLoading = false;
  DetailsModel detailsModel = DetailsModel();

  fetchDetailData(String trackNumber, context) async {
    isLoading = true;
    notifyListeners();
    log("DetailsController -> fetchDetailData()");
    TrackDetailsService.fetchDetailData(trackNumber).then((value) {
      if ( value["status"] == "200") {
        detailsModel = DetailsModel.fromJson(value);
        isLoading = false;
      } else {
        AppUtils.oneTimeSnackBar("Unable to fetch Data",
            context: context, bgColor: ColorTheme.red);
      }
      notifyListeners();
    }

    );
  }
  void clearDetails() {
    detailsModel = DetailsModel();
    isLoading = false;
    notifyListeners();
  }
}