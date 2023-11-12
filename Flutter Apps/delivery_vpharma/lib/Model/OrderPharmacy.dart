import 'package:delivery_vpharma/Model/Medicine.dart';
import 'package:delivery_vpharma/Model/Pharmacy.dart';
import 'package:delivery_vpharma/Model/Warehouse.dart';

class OrderPharmacy {
  dynamic ID;
  dynamic PharmacyID;
  dynamic OrderNum;
  dynamic OrderDate;
  Pharmacy? pharmacy;
  dynamic DeliveryPrice;
  int? OrderStatus;
  dynamic TotalPrice;
  List<Medicine>? medicines; // قائمة الأدوية
  Warehouse? warehouse;

  OrderPharmacy({
    this.ID,
    this.PharmacyID,
    this.OrderNum,
    this.pharmacy,
    this.OrderDate,
    this.warehouse,
    this.DeliveryPrice,
    this.OrderStatus,
    this.TotalPrice,
    this.medicines, // قائمة الأدوية
  });
}
