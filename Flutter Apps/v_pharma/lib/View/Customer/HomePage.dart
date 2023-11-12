import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:v_pharma/Controllers/PharmacyMedicineProvider.dart';
import 'package:v_pharma/View/Auth/Login.dart';
import 'package:v_pharma/View/Customer/CartPage.dart';
import 'package:v_pharma/View/Customer/ListOrder.dart';
import 'package:v_pharma/View/Customer/ListPharmacy.dart';
import 'package:v_pharma/View/Customer/ProfilePage.dart';
import 'package:v_pharma/View/Customer/Search_Medicine.dart';
import 'package:v_pharma/View/Customer/Search_Pharmacy.dart';
import 'package:v_pharma/constant/colors.dart';
import 'package:v_pharma/main.dart';
import 'package:v_pharma/widgets/Cards/CardPharmacy.dart';
import 'package:v_pharma/widgets/SearchInput.dart';
import 'package:v_pharma/widgets/textinputall.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Widget> bottomBarPages = [
  ListPharmacy(),
  ListOrder(),
  ProfilePage()
];

class _HomePageState extends State<HomePage> {
  final NotchBottomBarController _bottomBarController =
      NotchBottomBarController(index: 0);
  @override
  void initState() {
    authprovider.getUser();
    super.initState();
  }

  /// Controller to handle bottom nav bar and also handles initial page

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    pharmacyMedicineProvider = Provider.of<PharmacyMedicineProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: _bottomBarController.index == 0
                  ? Colors.transparent
                  : kPrimarycolor,
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: CartPage(), type: PageTransitionType.fade));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.shopping_cart,
                      color: kPrimarycolor,
                    ),
                  ),
                )
              ],
              centerTitle: true,
              title: _bottomBarController.index == 0
                  ? Text(
                      "Home Page",
                      style: TextStyle(color: kPrimarycolor),
                    )
                  : _bottomBarController.index == 1
                      ? Text("My Order")
                      : Text("Profile"),
              leading: _bottomBarController.index == 0
                  ? buildSearchBarMedicineOrPharmacy(context)
                  : _bottomBarController.index == 2
                      ? GestureDetector(
                          onTap: () {
                            authprovider.logout();
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: Login(),
                                  type: PageTransitionType.fade),
                            );
                          },
                          child: Icon(Icons.logout))
                      : Text("")),
          extendBody: true,
          body: Stack(
            children: [
              SizedBox(
                  height: height * .8,
                  child: bottomBarPages[_bottomBarController.index]),
              AnimatedNotchBottomBar(
                notchColor: kPrimarycolor,
                durationInMilliSeconds: 100,
                showLabel: false,
                bottomBarWidth: width,
                color: kBaseSecondryColor,
                onTap: (value) {
                  setState(() {
                    _bottomBarController.index = value;
                  });
                },
                notchBottomBarController: _bottomBarController,
                bottomBarItems: [
                  const BottomBarItem(
                    inActiveItem: SvgIcon(
                      'images/python.svg',
                      color: kPrimarycolor,
                    ),
                    activeItem: SvgIcon(
                      'images/python.svg',
                      color: kBaseSecondryColor,
                    ),
                  ),
                  const BottomBarItem(
                    inActiveItem: SvgIcon(
                      'images/list.svg',
                      color: kPrimarycolor,
                    ),
                    activeItem: SvgIcon(
                      'images/list.svg',
                      color: kBaseSecondryColor,
                    ),
                  ),
                  const BottomBarItem(
                    inActiveItem: SvgIcon(
                      'images/person.svg',
                      color: kPrimarycolor,
                    ),
                    activeItem: SvgIcon(
                      'images/person.svg',
                      color: kBaseSecondryColor,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

Widget buildSearchBarPharmacy(context) {
  return IconButton(
    icon: Icon(
      Icons.search,
      color: kPrimarycolor,
    ),
    onPressed: () {
      pharmacyMedicineProvider.getSearchPharmacyList(
          list: pharmacyMedicineProvider.listpharmacy);
      showSearch(context: context, delegate: SearchPharmacy());
    },
  );
}

Widget buildSearchBarMedicine(context) {
  return IconButton(
    icon: Icon(
      Icons.search,
      color: kPrimarycolor,
    ),
    onPressed: () {
      pharmacyMedicineProvider.getSearchMedicineList(
          list: pharmacyMedicineProvider.listallmedicine);
      showSearch(context: context, delegate: SearchMedicine());
    },
  );
}

Widget buildSearchBarMedicineOrPharmacy(context) {
  return PopupMenuButton<String>(
    icon: Icon(
      Icons.search,
      color: kPrimarycolor,
    ),
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          value: 'pharmacy',
          child: Text('Search Pharmacy'),
        ),
        PopupMenuItem(
          value: 'medicine',
          child: Text('Search Medicine'),
        ),
      ];
    },
    onSelected: (String value) {
      if (value == 'pharmacy') {
        pharmacyMedicineProvider.getSearchPharmacyList(
            list: pharmacyMedicineProvider.listpharmacy);
        showSearch(context: context, delegate: SearchPharmacy());
      } else if (value == 'medicine') {
        pharmacyMedicineProvider.getSearchMedicineList(
            list: pharmacyMedicineProvider.listallmedicine);
        showSearch(context: context, delegate: SearchMedicine());
      }
    },
  );
}
