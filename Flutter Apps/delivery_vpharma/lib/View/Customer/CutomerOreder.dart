import 'package:delivery_vpharma/Controllers/CartProvider.dart';
import 'package:delivery_vpharma/constant/colors.dart';
import 'package:delivery_vpharma/main.dart';
import 'package:delivery_vpharma/widgets/Cards/CardOrderCustomer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerOrderPage extends StatefulWidget {
  const CustomerOrderPage({super.key});

  @override
  State<CustomerOrderPage> createState() => _CustomerOrderPageState();
}

class _CustomerOrderPageState extends State<CustomerOrderPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await cartProvider.getallOrderCustomerfromdelivery();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.isLoadinggetallordercutomer
        ? Center(
            child: CircularProgressIndicator(
              color: kPrimarycolor,
            ),
          )
        : cartProvider.listordercustomer.isEmpty
            ? Center(
                child: Text("There are no order at the moment"),
              )
            : RefreshIndicator(
                color: kPrimarycolor,
                onRefresh: () async {
                  await cartProvider.getallOrderCustomerfromdelivery();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartProvider.listordercustomer.length,
                  itemBuilder: (context, index) => CardOrderCustomer(
                      order: cartProvider.listordercustomer[index]),
                ),
              );
  }
}
