
import 'package:flutter/material.dart';



class LocationModels{

  final String latitude;
  final String longitude;
  final String address ;

  LocationModels(this.latitude, this.longitude, this.address);

}


class TruckModels{

  final int id ;
  final String title;
  final String description;


  TruckModels({required this.id, required this.title, required this.description});



}


