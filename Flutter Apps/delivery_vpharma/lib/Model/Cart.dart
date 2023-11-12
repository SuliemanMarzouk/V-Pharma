import 'package:delivery_vpharma/Model/Medicine.dart';

class CartItem {
  Medicine? medicine;
  int? quan;

  CartItem({this.medicine, this.quan});

  void updatequan() {
    this.quan = this.quan! + 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'medOrder': {
        'id': medicine?.toJson(),
        'quan': quan,
      },
    };
  }
}
