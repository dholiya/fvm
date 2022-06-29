
class Api {

  /// Live URL
  static String baseUrl = 'https://api.somthing.com/api/v1';
  static String apiKey = "XYZ";

  //Auhtentication
  static String login = baseUrl + '/auth/login';
  static String logout = baseUrl + '/auth/logout';
  static String registration = baseUrl + '/auth/registration';
  static String forgotPassword = baseUrl + '/auth/forgot-password';


}
