import 'package:flutter/material.dart';
import 'package:water_porter/models/location_models.dart';

import '../widgets/truck_options.dart';

class DashBoard extends StatefulWidget {
  // const DashBoard({Key? key}) : super(key: key);

  static const routeName = "/Dashboard";

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments as LocationModels;
    // final address = args.address;
    // final lat = args.latitude;
    // final long = args.longitude;
    // print(address);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
                color: Theme.of(context).colorScheme.primary,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.outlined_flag_rounded,
                    color: Theme.of(context).colorScheme.primary),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.payment_rounded,
                    color: Theme.of(context).colorScheme.primary),
                label: "Payments"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.primary),
                label: "Account")
          ],
        ),
        appBar: PreferredSize(
          preferredSize: Size(20.0, 40.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.white38,
            centerTitle: true,
            title: Text("Water Porter"),
          ),
        ),
        body: TruckAvailability(address: "address",lat: "lat",long: "long",));
  }
}
