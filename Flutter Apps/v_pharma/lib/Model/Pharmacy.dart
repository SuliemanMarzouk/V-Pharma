import 'package:v_pharma/Model/Medicine.dart';

class Pharmacy {
  dynamic id;
  dynamic PharmaLicense;
  dynamic PharmaName;
  dynamic PhoneNum;
  bool? status;
  List<Medicine>? listmedicine;
  dynamic pharmacistName;

  Pharmacy({this.PharmaLicense,this.PharmaName,this.PhoneNum,this.id,this.pharmacistName,this.status,this.listmedicine});
}