class AppConfig {
  //baseurl is set here
  static String baseurl = "https://erp.jeyemexpresscargo.com/api/";

  //key to store data from api function in LoginController in json format used in AppUtils to get access key & userid
  static const String loginData = 'logInData';

  static const String token = "token";

  static const String loggedIn = 'loggedIn';

  static const String ptyloggedIn = 'ptyloggedIn';

  // to store the digits
  static const String partyDigits = 'partyDigits';

  static const String username = 'username';
  static const String prtyusername = 'prtyusername';
}
