const baseURL = "http://192.168.1.210:8000/api";

class AppApi {
  static String LOGIN = '/login';
  static String SIGNUP = '/registerUserApi';
  static String GetAllPharmacyMedicine = '/PharmaMedicines';
  static String UpdateProfile(int id) => '/updateProfile/$id';
  static String ResetPassword(int id) => '/updatePasswordApi/$id';
  static String GetAllCustomerOrder(int id) => '/customerOrders/$id';
  static String PlaceOrder = '/placeOrder';
}
