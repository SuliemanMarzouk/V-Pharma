import 'package:delivery_vpharma/Model/Medicine.dart';
import 'package:delivery_vpharma/Model/Pharmacy.dart';

class OrderCustomer {
  dynamic ID;
  dynamic PharmacyID;
  dynamic OrderNum;
  dynamic OrderDate;
  dynamic Cusname;
  dynamic CusAdd;
  dynamic Cusphone;
  dynamic DeliveryPrice;
  int? OrderStatus;
  dynamic TotalPrice;
  List<Medicine>? medicines; // قائمة الأدوية
  Pharmacy? pharmacy;

  OrderCustomer({
    this.ID,
    this.PharmacyID,
    this.OrderNum,
    this.CusAdd,
    this.Cusname,
    this.Cusphone,
    this.pharmacy,
    this.OrderDate,
    this.DeliveryPrice,
    this.OrderStatus,
    this.TotalPrice,
    this.medicines, // قائمة الأدوية
  });
}
