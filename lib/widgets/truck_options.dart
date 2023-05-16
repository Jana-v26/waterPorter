import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_porter/providers/location_provider.dart';
import 'package:water_porter/screens/confirm_location.dart';

import '../api_services/user_address_api.dart';
import 'drop_location.dart';

enum ListOfTrucks { small, medium, large, heavy }

class TruckAvailability extends ConsumerWidget {
  final String address;
  final String lat;
  final String long;

  const TruckAvailability(
      {Key? key, required this.address, required this.lat, required this.long})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  arg = ref.watch(addressProvider);
    print(" truck page ${arg.value?.latitude}");
    // print(args[0].address);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: Colors.green,
                ),
                title: Text(arg.when(
                    data: (val) => val.address,
                    error: (error, _) => error.toString(),
                    loading: () => "Address")),
              ),
            ),
            Divider(),
            CustomCard(
              description: "Small Capacity truck",
              subtitle: ">2000 Liters",
              newColor: Colors.redAccent.shade100,
            ),
            CustomCard(
              description: "Medium Capacity truck",
              subtitle: ">5000 Liters",
              newColor: Colors.greenAccent.shade100,
            ),
            CustomCard(
              description: "High Capacity truck",
              subtitle: ">10000 Liters",
              newColor: Colors.orangeAccent.shade100,
            ),
            CustomCard(
              lat: lat,
              long: long,
              description: "Heavy Capacity truck",
              subtitle: ">20000 Liters",
              newColor: Colors.pinkAccent.shade100,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String description;
  final String subtitle;
  final Color newColor;
  final String? lat;
  final String? long;

  const CustomCard(
      {super.key,
      this.lat,
      this.long,
      required this.description,
      required this.subtitle,
      required this.newColor});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  // void _showBottomSheet() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       // showDragHandle: true,
  //       enableDrag: true,
  //       context: context,
  //       builder: (ctx) => FetchingDropLocation());
  // }

  void NavigateToConfirmLocation() async {
    await Navigator.of(context).pushNamed(PlottingUserLocation.routeName,
        arguments: {"lat": widget.lat, "long": widget.long});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: InkWell(
          onTap: () => NavigateToConfirmLocation(),
          child: Card(
            color: widget.newColor,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedImage(),
                ListTile(
                  title: Text(widget.description),
                  subtitle: Text(widget.subtitle),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_circle_right_outlined),
                    onPressed: () => NavigateToConfirmLocation,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Widget SizedImage() {
  return Container(
    width: 180,
    height: 50,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                "assets/images/camion_cisterna1_generated-removebg-preview.png"),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high)),
  );
}
