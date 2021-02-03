import 'dart:io';
import 'package:flutter/foundation.dart';

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place(
      {@required this.id,
      @required this.title,
      @required this.location,
      @required this.image});
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  //the default value of an optional parameter must be constant
  const PlaceLocation(
      {@required this.longitude, @required this.latitude, this.address});
}
