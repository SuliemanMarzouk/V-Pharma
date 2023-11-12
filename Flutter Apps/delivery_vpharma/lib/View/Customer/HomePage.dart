import 'package:delivery_vpharma/Controllers/AuthProvider.dart';
import 'package:delivery_vpharma/View/Customer/CutomerOreder.dart';
import 'package:delivery_vpharma/View/Customer/PharmacyOrder.dart';
import 'package:delivery_vpharma/widgets/Cards/CardOrderPharmacy.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:delivery_vpharma/View/Auth/Login.dart';
import 'package:delivery_vpharma/constant/colors.dart';
import 'package:delivery_vpharma/main.dart';

import '../../Controllers/CartProvider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      await authprovider.getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    cartProvider = Provider.of<CartProvider>(context);
    authprovider = Provider.of<AuthProvider>(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: kPrimarycolor,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        authprovider.logout();
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: Login(), type: PageTransitionType.fade),
                            (route) => false);
                      },
                      child: Icon(Icons.logout)),
                )
              ],
              bottom: TabBar(tabs: [
                Tab(
                  text: "Customer Orders",
                ),
                Tab(
                  text: "Pharmacies Orders",
                ),
              ]),
              centerTitle: true,
              title: Text("My Order"),
              leading: Switch(
                activeColor: kBaseColor,
                value: authprovider.user.status!,
                onChanged: (value) async {
                  authprovider.updateacyivate(status: value ? 1 : 0);
                  setState(() {});
                  if (authprovider.user.status!) {
                  } else {
                    cartProvider.getallOrderCustomerfromdelivery();
                    cartProvider.getallOrderPharmacyfromdelivery();
                  }
                },
              )),
          extendBody: true,
          body: TabBarView(
            children: [
              CustomerOrderPage(),
              PharmacyOrderPage(),
            ],
          ),
        ));
  }
}
