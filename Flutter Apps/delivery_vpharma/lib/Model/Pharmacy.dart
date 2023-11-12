import 'package:delivery_vpharma/Model/Medicine.dart';

class Pharmacy {
  dynamic id;
  dynamic PharmaLicense;
  dynamic PharmaName;
  dynamic PhoneNum;
  dynamic address;
  bool? status;
  List<Medicine>? listmedicine;
  dynamic pharmacistName;

  Pharmacy(
      {this.PharmaLicense,
      this.PharmaName,
      this.PhoneNum,
      this.id,
      this.address,
      this.pharmacistName,
      this.status,
      this.listmedicine});

  factory Pharmacy.fromjson(dynamic responsedata) {
    return Pharmacy(
      PharmaLicense: responsedata['PharmaLicense'],
      PharmaName: responsedata['PharmaName'],
      PhoneNum: responsedata['PhoneNum'],
      address: responsedata['Address'],
      pharmacistName: responsedata['pharmacistName'],
    );
  }
}
