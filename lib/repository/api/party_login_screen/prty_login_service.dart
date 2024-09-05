import 'dart:developer';
import '../../helper/api_helper.dart';

class PartyLoginService {
  static Future<dynamic> postLoginData(email, password) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "partylogin?email=$email&password=$password");
      return decodedData;
    } catch (e) {
      log("$e");
    }
  }
}
