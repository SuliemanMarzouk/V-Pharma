class Order {
  dynamic ID;
  dynamic PharmacyID;
  dynamic OrderNum;
  dynamic OrderDate;
  dynamic DeliveryPrice;
  int? OrderStatus;
  dynamic TotalPrice;
  Order(
      {this.DeliveryPrice,
      this.ID,
      this.OrderDate,
      this.OrderNum,
      this.OrderStatus,
      this.PharmacyID,
      this.TotalPrice});
}
