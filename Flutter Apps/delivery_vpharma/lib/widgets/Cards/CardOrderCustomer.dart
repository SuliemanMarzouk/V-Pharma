import 'package:delivery_vpharma/Controllers/CartProvider.dart';
import 'package:delivery_vpharma/Model/OrderCustomer.dart';
import 'package:delivery_vpharma/constant/colors.dart';
import 'package:delivery_vpharma/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardOrderCustomer extends StatelessWidget {
  OrderCustomer? order;
  CardOrderCustomer({this.order});

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "#${order!.ID}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text("Total Price: ${order!.TotalPrice} \$"),
            Text(""),
            Text("From: Pharmacy ${order!.pharmacy!.PharmaName} "),
            Text("Address Pharmacy: ${order!.pharmacy!.address} "),
            Text("Phone Pharmacy: ${order!.pharmacy!.PhoneNum} "),
            Text(""),
            Text("To: Cutomer ${order!.Cusname} "),
            Text("Address Cutomer: ${order!.CusAdd} "),
            Text("Phone Cutomer: ${order!.Cusphone} "),
            Text(""),
            Text(
                "Status Order: ${order!.OrderStatus == 2 ? "Waiting" : order!.OrderStatus == 3 ? "On the way" : order!.OrderStatus == 4 ? "Delivered" : order!.OrderStatus == 5 ? "Canceled" : ""}"),
            Text(
                "Order Date: ${DateFormat("yyyy-MM-dd").format(DateTime.parse(order!.OrderDate))}"),
            Divider(
              color: kPrimarycolor,
            ),
            Text("Medicines: "),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: order!.medicines!.length,
              itemBuilder: (context, index) =>
                  Text("${index + 1} ${order!.medicines![index].MedicineName}"),
            ),
            order!.OrderStatus == 2
                ? Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.green)),
                              onPressed: () async {
                                await cartProvider.updatestausorder(
                                    idorder: order!.ID, status: 3);
                              },
                              child: Text("Approve"))),
                      VerticalDivider(
                        color: Colors.transparent,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.red)),
                              onPressed: () async {
                                await cartProvider.updatestausorder(
                                    idorder: order!.ID, status: 5);
                              },
                              child: Text("Reject"))),
                    ],
                  )
                : order!.OrderStatus == 3
                    ? Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.green)),
                                  onPressed: () async {
                                    await cartProvider.updatestausorder(
                                        idorder: order!.ID, status: 4);
                                  },
                                  child: Text("Delivered"))),
                        ],
                      )
                    : Center(
                        child: Text(
                          "${order!.OrderStatus == 4 ? "Delivered" : order!.OrderStatus == 5 ? "Canceled" : ""}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
