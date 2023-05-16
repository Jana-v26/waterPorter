import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_porter/models/location_models.dart';
import 'package:water_porter/screens/confirm_location.dart';
import 'package:water_porter/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'providers/location_provider.dart';
import 'package:location/location.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Porter',
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer),
          bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
              type: BottomNavigationBarType.fixed,
              backgroundColor: kColorScheme.primaryContainer,
              elevation: 5,
              showSelectedLabels: true),
          textTheme: ThemeData()
              .textTheme
              .copyWith(titleMedium: TextStyle(fontFamily: "OpenSans"))),
      routes: {
        DashBoard.routeName: (context) => DashBoard(),
        PlottingUserLocation.routeName: (context) => PlottingUserLocation()
      },
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends ConsumerWidget {
  SplashScreen({Key? key}) : super(key: key);

  // final Location location = Location();
  //
  // Future<void> checkPermission() async {
  //   // Location location = Location();
  //
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return null;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }
  //
  //   final latitude = location.getLocation().then((value) => value.latitude);
  //   final longitude = location.getLocation().then((value) => value.longitude);
  //
  //
  //
  //
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ref.watch(checkPermission.notifier).checkPermission().then(
        (value) =>
            Navigator.pushReplacementNamed(context, DashBoard.routeName));
    // final g = args.then((value) => value?.latitude);
    print("args $args");
    // print("222 $g");
    print("inside build");
    // checkPermission();
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Water Porter",
            style: TextStyle(color: Colors.blue, fontSize: 55),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location location = Location();
  bool locationEnabled = false;

  @override
  void initState() {
    super.initState();
    // checkLocationEnabled();
    print("check permission");
    checkPermission().then((value) => fetchingLocation());

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //
    // });
  }

  Future<void> checkPermission() async {
    // Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
  }

  late LocationModels h;

  fetchingLocation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Fetching Details..",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        // duration: Duration(milliseconds: 400),
      ),
    );
    var locationData = await location.getLocation();
    print(locationData.latitude);
    print(locationData.longitude);

    final String lat = locationData.latitude.toString();
    final String long = locationData.longitude.toString();
    // final String addressData = await fetchAddress(lat, long);

    // h = LocationModels(lat, long, addressData);
    // print(h[0].address);

    // ScaffoldMessenger.of(context).clearSnackBars();

    Navigator.pushReplacementNamed(context, DashBoard.routeName, arguments: h);

// return h;
  }

  fetchAddress(lat, long) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyCrwGCNzHgxDRD6sX48W3yi--PgRQtwXZg");
    final response = await http.get(url);
    final responseData = json.decode(response.body);

    return responseData["results"][0]["formatted_address"].toString();
    // print("responseData ${responseData["results"][0]["formatted_address"]}");
  }

  @override
  Widget build(BuildContext context) {
    print("inside build");
    // checkPermission();
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Water Porter",
            style: TextStyle(color: Colors.blue, fontSize: 55),
          ),
        ),
      ),
    );
  }
}
