import 'package:delivery_vpharma/Controllers/CartProvider.dart';
import 'package:delivery_vpharma/constant/colors.dart';
import 'package:delivery_vpharma/main.dart';
import 'package:delivery_vpharma/widgets/Cards/CardOrderPharmacy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PharmacyOrderPage extends StatefulWidget {
  const PharmacyOrderPage({super.key});

  @override
  State<PharmacyOrderPage> createState() => _PharmacyOrderPageState();
}

class _PharmacyOrderPageState extends State<PharmacyOrderPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await cartProvider.getallOrderPharmacyfromdelivery();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.isLoadinggetallorderpharmacy
        ? Center(
            child: CircularProgressIndicator(
              color: kPrimarycolor,
            ),
          )
        : cartProvider.listorderpharmacy.isEmpty
            ? Center(
                child: Text("There are no order at the moment"),
              )
            : RefreshIndicator(
                color: kPrimarycolor,
                onRefresh: () async {
                  await cartProvider.getallOrderPharmacyfromdelivery();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartProvider.listorderpharmacy.length,
                  itemBuilder: (context, index) => CardOrderPharmacy(
                      order: cartProvider.listorderpharmacy[index]),
                ),
              );
  }
}
