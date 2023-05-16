import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_porter/main.dart';

class PlottingUserLocation extends StatefulWidget {
  static const routeName = "/PlotUserLocation";

  // const PlottingUserLocation({Key? key}) : super(key: key);

  @override
  State<PlottingUserLocation> createState() => _PlottingUserLocationState();
}

class _PlottingUserLocationState extends State<PlottingUserLocation> {
  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = Set();

  Set<Marker> getMarkers(lat, long) {
    _markers.clear();

    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(""),
            position: LatLng(double.parse(lat), double.parse(long)),
            infoWindow: InfoWindow(
              title: "Drop location",
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure)),
      );
    });

    return _markers;
  }




  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final lat = args["lat"];
    final long = args["long"];
    print(args["lat"]);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: size.height * 0.85,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(lat), double.parse(long)),
                    zoom: 15),
                // on below line we are setting markers on the map
                markers: getMarkers(lat, long),

                // on below line specifying map type.
                mapType: MapType.normal,
                // on below line setting user location enabled.
                myLocationEnabled: true,
                // on below line setting compass enabled.
                compassEnabled: true,
                // on below line specifying controller on map complete.
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),

            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)), color: kColorScheme.onPrimaryContainer),
              // color: Colors.blue,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Confirm Location"),
                ),
              ),
            ))
            //
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            //   onPressed: (){},child: Text(""),),

            // ElevatedButton(
            // onPressed: () {},
            // child: Text("Confirm Location"),
            // )
          ],
        ),
      ),
    );
  }
}
