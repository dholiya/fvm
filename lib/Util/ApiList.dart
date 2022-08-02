
class Api {

  /// Live URL
  /// https://fvmnode.herokuapp.com/api/user
  static String baseUrl = 'https://fvmnode.herokuapp.com/api';
  static String images = 'https://fvmnode.herokuapp.com/';
  // static String apiKey = "XYZ";

  //Auhtentication
  static Uri registration = Uri.parse(baseUrl + '/user');
  static Uri verifyOTP = Uri.parse(baseUrl + '/user');
  static Uri login = Uri.parse(baseUrl + '/user');
  static Uri sendOTP = Uri.parse(baseUrl + '/user/otp');

  //product
  static Uri addProduct = Uri.parse(baseUrl + '/product');
  static Uri getProductByID = Uri.parse(baseUrl + '/product');
  static Uri sellerProduct = Uri.parse(baseUrl + '/product/seller');
  static Uri updateProduct = Uri.parse(baseUrl + '/product');
  static Uri deleteProduct = Uri.parse(baseUrl + '/product');
  static Uri getProduct = Uri.parse(baseUrl + '/product');




  static String logout = baseUrl + '/auth/logout';


}
