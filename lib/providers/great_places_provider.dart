import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helpers.dart';
import '../helpers/location_helper.dart';

//here, the data base is the sqllite device database
class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(
        longitude: location.longitude,
        latitude: location.latitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DBhelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBhelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(
                  latitude: item['loc_lat'],
                  longitude: item['loc_lng'],
                  address: item['address']),
              image: File(item['image']),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> delDatabase() async {
    await DBhelper.delDatabase();
    notifyListeners();
  }
}
