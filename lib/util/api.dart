class Api {
  static String getallproduct = "http://192.168.1.36:8000/api/v1/getAllProduct";
  static String addproduct = "http://192.168.1.36:8000/api/v1/AddProduct";
  static String deleteproduct = "http://192.168.1.36:8000/api/v1/DeleteProduct";
  static String updateproduct = "http://192.168.1.36:8000/api/v1/UpdateProduct";
  static String getallcategory =
      "http://192.168.1.36:8000/api/v1/getAllCategory";

  static String addcategory = "http://192.168.1.36:8000/api/v1/AddCategory";

  static String deletecategory =
      "http://192.168.1.36:8000/api/v1/DeleteCategory";

  static String getcartlist = "http://192.168.1.36:8000/api/v1/getCartItems";

  static String itemcartdetails = "http://192.168.1.36:8000/api/v1/itemwithid";

  static String getusers = "http://192.168.1.36:8000/api/v1/getAllUsers";

  static String getuserwithemail =
      "http://192.168.1.36:8000/api/v1/getuserwithemail";

  static String notification = "https://fcm.googleapis.com/fcm/send";
}
