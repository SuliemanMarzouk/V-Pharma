class Medicine {
  dynamic id;
  dynamic MedicineName;
  dynamic MedicineDetails;
  dynamic ProductionDate;
  dynamic ExpireDate;
  dynamic Price;
  dynamic Quantity;
  dynamic PharmacyID;

  Medicine(
      {this.ExpireDate,
      this.MedicineDetails,
      this.MedicineName,
      this.Price,
      this.ProductionDate,
      this.Quantity,
      this.PharmacyID,
      this.id});

  int toJson() {
    return id;
  }
}
