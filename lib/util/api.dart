class Api {
  static String baseurl = 'https://rayka.opecommerce.com/index.php';
  static String getallproduct = "${Api.baseurl}/api/v1/getAllProduct";
  static String addproduct = "${Api.baseurl}/api/v1/AddProduct";
  static String deleteproduct = "${Api.baseurl}/api/v1/DeleteProduct";
  static String updateproduct = "${Api.baseurl}/api/v1/UpdateProduct";
  static String getallcategory = "${Api.baseurl}/api/v1/getAllCategory";

  static String addcategory = "${Api.baseurl}/api/v1/AddCategory";

  static String deletecategory = "${Api.baseurl}/api/v1/DeleteCategory";

  static String getcartlist = "${Api.baseurl}/api/v1/getCartItems";

  static String itemcartdetails = "${Api.baseurl}/api/v1/itemwithid";

  static String getusers = "${Api.baseurl}/api/v1/getAllUsers";

  static String getuserwithemail = "${Api.baseurl}/api/v1/getuserwithemail";

  static String notification = "https://fcm.googleapis.com/fcm/send";
}
