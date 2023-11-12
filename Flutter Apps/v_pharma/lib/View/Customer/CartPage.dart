import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:v_pharma/Controllers/AuthProvider.dart';

import 'package:v_pharma/Controllers/CartProvider.dart';
import 'package:v_pharma/Model/Cart.dart';
import 'package:v_pharma/View/Customer/HomePage.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/textinputall.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

final addresscontroller = TextEditingController();

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    addresscontroller.text = authprovider.user.Address;
    super.initState();
  }

  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    authprovider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      bottomSheet: Container(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Total Price: "),
                    Text("${cartProvider.totalPrice}")
                  ],
                ),
                Row(
                  children: [
                    Text("Your Address: "),
                    Expanded(
                      child: SizedBox(
                        height: 75,
                        width: 300,
                        child: Form(
                          key: key,
                          child: TextInpuAll(
                            controller: addresscontroller,
                            isPassword: false,
                            label: "your address",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimarycolor,
        onPressed: () async {
          if (key.currentState!.validate()) {
            if (await cartProvider.sendordershop(
                address: addresscontroller.text,
                pharmaid: cartProvider.idpharma.toString())) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: "The order has been sent",
                desc: "please wait to review",
                btnOkOnPress: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                          child: HomePage(), type: PageTransitionType.fade),
                      (route) => false);
                },
                btnOkText: "Done",
              ).show();
            } else {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: "Error",
                desc: "An unexpected error occurred. Please try again later",
                btnOkOnPress: () {},
                btnOkText: "Try Again",
              ).show();
            }
          } else {
            Flushbar(
              message: "Please enter your address",
              duration: Duration(seconds: 3),
            ).show(context);
          }
        },
        child: cartProvider.isLoadingplaceorder
            ? CircularProgressIndicator(
                color: kBaseColor,
              )
            : Text("Buy"),
      ),
      body: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          CartItem cartItem = cartProvider.cartItems[index];
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Slidable(
              startActionPane: ActionPane(motion: BehindMotion(), children: [
                SlidableAction(
                  label: "Delete",
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  spacing: 10,
                  onPressed: (context) {
                    cartProvider.removeFromCart(cartItem);
                  },
                )
              ]),
              child: Card(
                elevation: 5,
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (cartItem.quan! > 1) {
                            setState(() {
                              cartItem.quan = cartItem.quan! -
                                  1; // تقليل عدد المنتجات بالنقر على زر الإزالة
                            });
                          }
                        },
                      ),
                      Text(cartItem.quan.toString()), // عرض عدد المنتجات
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            cartItem.quan = cartItem.quan! +
                                1; // زيادة عدد المنتجات بالنقر على زر الإضافة
                          });
                        },
                      ),
                    ],
                  ),
                  title: Text(cartItem.medicine!.MedicineName!), // اسم المنتج
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Price"),
                        VerticalDivider(
                          color: Colors.transparent,
                        ),
                        Text(
                            "${cartItem.medicine!.Price!.toString()} \$"), // تفاصيل المواصفة
                      ],
                    ),
                  ),
                  // trailing: Text(product.orderStatus!), // حالة الطلبs
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
