class Warehouse {
  dynamic WHName;
  dynamic Address;
  dynamic PhoneNum;
  Warehouse({this.Address, this.PhoneNum, this.WHName});

  factory Warehouse.fromJson(dynamic responsedata) {
    return Warehouse(
      Address: responsedata['Address'],
      PhoneNum: responsedata['PhoneNum'],
      WHName: responsedata['WHName'],
    );
  }
}
