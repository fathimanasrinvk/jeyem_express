import 'dart:developer';

import '../../../../core/utils/app_utils.dart';
import '../../../helper/api_helper.dart';

class TrackDetailsService {
  static Future<dynamic> fetchDetailData( String trackNumber) async {
    log("TrackDetailsService -> fetchDetailData()");
    try {
      var decodedData = await ApiHelper.getData(
        endPoint: "bookingget/$trackNumber",
      );
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}