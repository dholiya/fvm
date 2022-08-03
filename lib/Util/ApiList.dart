
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
  static String updateProfile = baseUrl + '/user/update/';

  //product
  static Uri addProduct = Uri.parse(baseUrl + '/product');
  static String getProductByID = baseUrl + '/product/';
  static String sellerProduct = baseUrl + '/product/seller/';
  static String updateProduct =baseUrl + '/product/';
  static String deleteProduct = baseUrl + '/product/';
  static Uri getProduct = Uri.parse(baseUrl + '/product');


  //favorite
    static Uri addFavorite = Uri.parse(baseUrl + '/favorite');
  static String getFavorite = baseUrl + '/favorite/';
  static String deleteFavorite = baseUrl + '/favorite/';



  //favorite
  static Uri placedBID = Uri.parse(baseUrl + '/bid');
  static String getByPIDBid = baseUrl + '/bid/';
  static String deleteByPIDBid = baseUrl + '/bid/';
  static Uri getByIDAmountBid = Uri.parse(baseUrl + '/bid/buyer');



  static String logout = baseUrl + '/auth/logout';


}
