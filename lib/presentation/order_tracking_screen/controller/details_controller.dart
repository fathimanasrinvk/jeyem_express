import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../repository/api/common/model/details_model.dart';
import '../../../repository/api/common/service/serviceeee.dart';

class DetailsController extends ChangeNotifier {
  bool isLoading = false;
  DetailsModel detailsModel = DetailsModel();
  String username = ''; // Add a variable to store the username

  // Method to fetch the username from SharedPreferences
  Future<void> fetchUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username =
        prefs.getString(AppConfig.username) ?? ''; // Retrieve the username
    notifyListeners();
  }

  fetchDetailData(String trackNumber, context) async {
    isLoading = true;
    notifyListeners();
    log("DetailsController -> fetchDetailData()");
    TrackDetailsService.fetchDetailData(trackNumber).then((value) {
      if (value != null && value["status"] == "200") {
        detailsModel = DetailsModel.fromJson(value);
        isLoading = false;
      } else {
        clearDetails();
        AppUtils.oneTimeSnackBar("Not Found",
            context: context, bgColor: ColorTheme.lightcolor);
      }
      notifyListeners();
    });
  }

  void clearDetails() {
    detailsModel = DetailsModel();
    isLoading = false;
    notifyListeners();
  }
}
