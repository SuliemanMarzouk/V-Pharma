class User {
  int? id;
  int? DeleiveryID;
  dynamic name;
  dynamic FullName;
  dynamic PhoneNum;
  bool? status;

  User(
      {this.id,
      this.status,
      this.DeleiveryID,
      this.name,
      this.FullName,
      this.PhoneNum});

  factory User.fromJson(Map<String, dynamic> responsedata) {
    return User(
        id: responsedata['user']['id'] ?? "",
        name: responsedata['user']['name'] ?? "",
        DeleiveryID: responsedata['delivery']['ID'],
        FullName: responsedata['delivery']['FullName'],
        PhoneNum: responsedata['delivery']['PhoneNum'],
        status: responsedata['delivery']['status'] == 1 ? true : false);
  }
  factory User.fromJsonafterupdatestatus(Map<String, dynamic> responsedata) {
    return User(status: responsedata['delivery']['status'] == 1 ? true : false);
  }
}
