const baseURL = "http://192.168.1.210:8000/api";

class AppApi {
  static String LOGIN = '/deliverylogin';
  static String UpdateStatus(int id) => '/updateStatus/$id';
  static String GetAllDeliveryOrder(int id) => '/deliveryOrders/$id';
  static String DeliverySubmitOrder(int id) => '/deliverySubmitOrder/$id';
  static String DeliverySubmitOrderPharmacy(int id) =>
      '/deliverySubmitPharmaOrder/$id';
}
