// import 'dart:convert';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/location_models.dart';
// import 'package:http/http.dart' as http;
//
//
//
//
//
// class LocationNotifier extends StateNotifier<List<LocationModels>> {
//   LocationNotifier() : super([]);
//
//    addLocationDetails(LocationModels locationData ) {
//     state = [];
//     [...state, locationData
//     ];
//     return locationData;
//   }
//
//
//
// }
//
//
// final locationDetails =
//     StateNotifierProvider<LocationNotifier, List<LocationModels>>(
//         (ref) => LocationNotifier());
//
//
//
//
// fetchAddress(lat, long) async {
//   final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyCrwGCNzHgxDRD6sX48W3yi--PgRQtwXZg");
//   final response = await http.get(url);
//   final responseData = json.decode(response.body);
//
//
//   return responseData["results"][0]["formatted_address"].toString();
//   // print("responseData ${responseData["results"][0]["formatted_address"]}");
//
//
//
// }
//
//
// final locationProviders = FutureProvider((ref) => fetchAddress());
//
//
// final getlat = StateProvider((ref) => null)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api_services/user_address_api.dart';
import 'package:location/location.dart';









class CheckPermission extends StateNotifier<ApiService>{
  CheckPermission() : super(ApiService(0, 0, 0, ""));

  Future<ApiService?> checkPermission() async {
    final Location location = Location();

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

    final lat = await location.getLocation().then((value) => value.latitude);
    final long = await location.getLocation().then((value) => value.longitude);

    print("$lat,  $long");

    ApiService apiService = ApiService(1,  lat! , long!, "");
    state = apiService;
print(state.latitude);
// return apiService;


  }




}

final checkPermission = StateNotifierProvider<CheckPermission, ApiService>((ref) {
  // ref.watch(addressProvider);
  return CheckPermission();});


final addressProvider =
FutureProvider<ApiService>((ref) async {

  final coordinates = ref.watch(checkPermission);
  print("coordinates ${coordinates.latitude}");


  final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=AIzaSyCrwGCNzHgxDRD6sX48W3yi--PgRQtwXZg");
  final response = await http.get(url);

  final responseData = json.decode(response.body);
  final res = responseData["results"][0]["formatted_address"];

  print("response ${response}");
  // final address = response["results"][0]["formatted_address"];
  final data = ApiService(1, coordinates.latitude, coordinates.longitude, res);

  return data;
  // Navigator.pushReplacementNamed(context, routeName)


  // return response;
});

