import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function selectPlace;
  LocationInput(this.selectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  Location location = Location();
  var _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<void> _getCurrentUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    // final locationData = await Location().getLocation();
    // print(_locationData.latitude);
    // print(_locationData.longitude);
    _showPreview(_locationData.latitude, _locationData.longitude);
    widget.selectPlace(_locationData.latitude, _locationData.longitude);
  }

  Future<void> _selectOnMap() async {
    //tells dart what kind of data to return in angle brackets
    // final selectedLocation = await Navigator.push<LatLng>(
    final LatLng selectedLocation = await Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(isSelecting: true)));
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectPlace(selectedLocation.latitude, selectedLocation.longitude);
    //..
  }

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text('No Location Chosen')
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).accentColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).accentColor,
            )
          ],
        )
      ],
    );
  }
}
