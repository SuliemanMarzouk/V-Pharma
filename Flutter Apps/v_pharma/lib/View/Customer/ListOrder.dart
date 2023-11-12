import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/CartProvider.dart';
import 'package:v_pharma/Model/Order.dart';
import 'package:v_pharma/main.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await cartProvider.getallOrderfromuser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    return ListView.builder(
      itemCount: cartProvider.listorder.length,
      itemBuilder: (context, index) =>
          CardOrder(order: cartProvider.listorder[index]),
    );
  }
}

class CardOrder extends StatelessWidget {
  Order? order;
  CardOrder({this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "#${order!.ID}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Text("Total Price: ${order!.TotalPrice} \$"),
            Text(
                "${order!.OrderStatus == 0 ? "Waiting" : order!.OrderStatus == 1 ? "In process" : order!.OrderStatus == 2 ? "Accepted" : order!.OrderStatus == 3 ? "Delivering" : order!.OrderStatus == 4 ? "Delivered" : "Rejected"}"),
          ],
        ),
      ),
    );
  }
}
