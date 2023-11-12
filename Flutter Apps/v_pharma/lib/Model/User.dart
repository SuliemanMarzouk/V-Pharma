class User {
  int? id;
  int? Customerid;
  dynamic name;
  dynamic email;
  dynamic NationNum;
  dynamic FullName;
  dynamic Address;
  dynamic PhoneNum;
  dynamic Gender;
  dynamic Birthdate;

  User(
      {this.id,
      this.email,
      this.Customerid,
      this.name,
      this.Address,
      this.Birthdate,
      this.FullName,
      this.Gender,
      this.NationNum,
      this.PhoneNum});

  factory User.fromJson(Map<String, dynamic> responsedata) {
    return User(
      Customerid: responsedata['customer']['ID'],
      id: responsedata['user']['id'] ?? "",
      name: responsedata['user']['name'] ?? "",
      email: responsedata['user']['email'] ?? "",
      Address: responsedata['customer']['Address'],
      Birthdate: responsedata['customer']['Birthdate'],
      FullName: responsedata['customer']['FullName'],
      Gender: responsedata['customer']['Gender'],
      NationNum: responsedata['customer']['NationNum'],
      PhoneNum: responsedata['customer']['PhoneNum'],
    );
  }
}
